import 'dart:async';

import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ref_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_websocket_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/phoenix_group_join_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/phoenix_group_leave_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/phoenix_notification_join_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/phoenix_send_text_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/phoenix_send_borrow_message.dart';

abstract class IPhoenixWsNotifier extends PhoenixNotifier {
  final IPhoenixWebSocketManager websocketManager;
  final AuthenticationProvider authenticationProvider;
  StreamSubscription<dynamic>? _subscription;
  Timer? _reconnectTimer;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;

  late bool isGraceFullExit = false;
  final Set<String> _joinedTopics = {};

  IPhoenixWsNotifier(
    this.websocketManager,
    this.authenticationProvider,
    super.levelUpProvider,
    super.notificationProvider,
    super.notificationManager,
    super.groupManager,
    super.groupService,
  );

  String get accessToken => authenticationProvider.accessToken;
  bool get isTokenAvailable => accessToken.isNotEmpty;

  bool isTopicJoined(String topic) => _joinedTopics.contains(topic);

  Future _listen() async {
    if (!isTokenAvailable || _subscription != null) {
      print(
          '⚠️ Unable to connect: token=${isTokenAvailable}, sub=${_subscription != null}');
      return;
    }

    print('🔌 Starting WebSocket connection...');

    try {
      var stream = await websocketManager.createChannel(accessToken);

      _subscription = stream.listen(
        (event) {
          _reconnectAttempts = 0;
          print('📨 Event received in the notifier');
          var handler = getPhoenixMessage(event);
          handler?.handle();
        },
        onDone: () async {
          print('🔚 Stream ended');
          _subscription = null;
          websocketManager.close();

          if (_shouldReconnect && !isGraceFullExit) {
            print('🔄 Scheduling reconnection...');
            await _scheduleReconnect();
          } else {
            _joinedTopics.clear();
          }
        },
        onError: (error) async {
          print('❌ Error in stream: $error');
          _subscription = null;

          if (_shouldReconnect && !isGraceFullExit) {
            await _scheduleReconnect();
          }
        },
      );
    } catch (e) {
      print('❌ Error connecting to WebSocket: $e');
      _subscription = null;

      if (_shouldReconnect && !isGraceFullExit) {
        await _scheduleReconnect();
      }
    }
  }

  Future<void> _scheduleReconnect() async {
    _reconnectTimer?.cancel();

    final delay = Duration(
      seconds: (2 << _reconnectAttempts).clamp(2, 30),
    );

    _reconnectAttempts++;
    print('Reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(delay, () async {
      await _reconnectWithTopics();
    });
  }

  Future<void> _reconnectWithTopics() async {
    final topicsToRejoin = List<String>.from(_joinedTopics);
    _joinedTopics.clear();

    await reconnect();

    for (final topic in topicsToRejoin) {
      if (topic.startsWith('group:')) {
        final groupId = topic.replaceFirst('group:', '');
        await joinGroup(groupId);
      } else if (topic.startsWith('notification:')) {
        final memberId = topic.replaceFirst('notification:', '');
        await joinNotifications(memberId);
      }
    }

    print('Reconnected and rejoined ${topicsToRejoin.length} topics');
  }

  Future logIn() async {
    _shouldReconnect = true;
    isGraceFullExit = false;
    await _listen();
  }

  Future reconnect() async {
    _subscription?.cancel();
    _subscription = null;
    websocketManager.close();
    _joinedTopics.clear();
    await logIn();
  }

  void logOut() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _subscription = null;
    websocketManager.close();
    _joinedTopics.clear();
    isGraceFullExit = true;
  }

  Future<void> joinGroup(String groupId);
  Future<void> leaveGroup(String groupId);
  Future<void> sendTextMessage(String groupId, String content,
      {List<String> mentions = const [], String? replyTo});
  Future<void> sendBorrowMessage(
      String groupId, String content, String garmentId,
      {List<String> mentions = const [], String? replyTo});
  Future<void> sendTradeOfferOnGroup(
      String groupId, String content, String garmentId);
  Future<void> joinNotifications(String memberId);
}

class SinglePhoenixWsNotifier extends IPhoenixWsNotifier {
  SinglePhoenixWsNotifier(
    super.websocketManager,
    super.authenticationProvider,
    super.levelUpProvider,
    super.notificationProvider,
    super.notificationManager,
    super.groupManager,
    super.groupService,
  );

  @override
  Future<void> joinGroup(String groupId) async {
    final topic = 'group:$groupId';

    if (isTopicJoined(topic)) return;

    await websocketManager.createChannel(accessToken);

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixGroupJoinMessage(groupId, ref);

    websocketManager.sendMessage(message);
    _joinedTopics.add(topic);
  }

  @override
  Future<void> leaveGroup(String groupId) async {
    final topic = 'group:$groupId';

    if (!isTopicJoined(topic)) return;

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixGroupLeaveMessage(groupId, ref);

    websocketManager.sendMessage(message);
    _joinedTopics.remove(topic);
    return Future.value();
  }

  @override
  Future<void> sendTextMessage(
    String groupId,
    String content, {
    List<String> mentions = const [],
    String? replyTo,
  }) async {
    final topic = 'group:$groupId';

    if (!isTopicJoined(topic)) {
      await joinGroup(groupId);
    }

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixSendTextMessage(
      groupId: groupId,
      content: content,
      mentions: mentions,
      replyTo: replyTo,
      ref: ref,
    );

    websocketManager.sendMessage(message);
  }

  @override
  Future<void> sendBorrowMessage(
    String groupId,
    String content,
    String garmentId, {
    List<String> mentions = const [],
    String? replyTo,
  }) async {
    final topic = 'group:$groupId';

    if (!isTopicJoined(topic)) {
      await joinGroup(groupId);
    }

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixSendBorrowMessage(
      groupId: groupId,
      content: content,
      garmentId: garmentId,
      mentions: mentions,
      replyTo: replyTo,
      ref: ref,
    );

    websocketManager.sendMessage(message);
  }

  @override
  Future<void> sendTradeOfferOnGroup(
      String groupId, String content, String garmentId) async {
    await sendBorrowMessage(groupId, content, garmentId);
  }

  @override
  Future<void> joinNotifications(String memberId) async {
    final topic = 'notification:$memberId';

    if (isTopicJoined(topic)) return;

    websocketManager.createChannel(accessToken).ignore();

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixNotificationJoinMessage(memberId, ref);

    websocketManager.sendMessage(message);
    _joinedTopics.add(topic);
  }
}
