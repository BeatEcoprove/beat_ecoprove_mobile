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

  String get accessToken => authenticationProvider.refreshToken;
  bool get isTokenAvailable => accessToken.isEmpty;

  bool isTopicJoined(String topic) => _joinedTopics.contains(topic);

  Future _listen() async {
    if (isTokenAvailable) {
      return;
    }

    var channel = await websocketManager.createChannel(accessToken);

    channel.stream.listen(
      (event) {
        var handler = getPhoenixMessage(event);

        if (handler == null) {
          return;
        }

        handler.handle();
      },
      onDone: () async {
        websocketManager.close();
        _joinedTopics.clear();

        if (!isGraceFullExit) {
          return await reconnect();
        }

        isGraceFullExit = !isGraceFullExit;
      },
      onError: (error) {
        print('Erro no WebSocket: $error');
      },
    );
  }

  Future logIn() async {
    await _listen();
  }

  void logOut() {
    websocketManager.close();
    _joinedTopics.clear();
    isGraceFullExit = true;
  }

  Future reconnect() async {
    if (!websocketManager.isAlive()) {
      await logIn();
    }
  }

  void joinGroup(String groupId);
  void leaveGroup(String groupId);
  void sendTextMessage(String groupId, String content,
      {List<String> mentions = const [], String? replyTo});
  void sendBorrowMessage(String groupId, String content, String garmentId,
      {List<String> mentions = const [], String? replyTo});
  void sendTradeOfferOnGroup(String groupId, String content, String garmentId);
  void joinNotifications(String memberId);
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
  void joinGroup(String groupId) {
    final topic = 'group:$groupId';

    if (isTopicJoined(topic)) {
      return;
    }

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixGroupJoinMessage(groupId, ref);

    websocketManager.sendMessage(message);
    _joinedTopics.add(topic);
  }

  @override
  void leaveGroup(String groupId) {
    final topic = 'group:$groupId';

    if (!isTopicJoined(topic)) {
      return;
    }

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixGroupLeaveMessage(groupId, ref);

    websocketManager.sendMessage(message);
    _joinedTopics.remove(topic);
  }

  @override
  void sendTextMessage(String groupId, String content,
      {List<String> mentions = const [], String? replyTo}) {
    final topic = 'group:$groupId';

    if (!isTopicJoined(topic)) {
      joinGroup(groupId);
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
  void sendBorrowMessage(String groupId, String content, String garmentId,
      {List<String> mentions = const [], String? replyTo}) {
    final topic = 'group:$groupId';

    if (!isTopicJoined(topic)) {
      joinGroup(groupId);
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
  void sendTradeOfferOnGroup(String groupId, String content, String garmentId) {
    sendBorrowMessage(groupId, content, garmentId);
  }

  @override
  void joinNotifications(String memberId) {
    final topic = 'notification:$memberId';

    if (isTopicJoined(topic)) {
      return;
    }

    final ref = PhoenixRefManager.generateRef();
    final message = PhoenixNotificationJoinMessage(memberId, ref);

    websocketManager.sendMessage(message);
    _joinedTopics.add(topic);
  }
}
