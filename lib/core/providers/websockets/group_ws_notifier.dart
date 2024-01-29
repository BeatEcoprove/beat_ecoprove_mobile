import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_group_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_sendtext_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/websocket_notifier.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class GroupWSNotifier extends Notifier {
  final WSSessionManager websocketNotifier;
  final AuthenticationProvider authenticationProvider;
  late bool isListening = false;

  GroupWSNotifier(
      this.websocketNotifier,
      this.authenticationProvider,
      LevelUpProvider levelUpProvider,
      NotificationProvider notificationProvider,
      NotificationManager notificationManager,
      GroupService groupService,
      GroupManager groupManager)
      : super(
          levelUpProvider,
          notificationProvider,
          notificationManager,
          groupService,
          groupManager,
        );

  void sendGroupMessage(String groupId, String message) {
    websocketNotifier.sendMessage(
        groupId,
        SendTextWebSocketMessage(
          groupId,
          message,
        ),
        authenticationProvider.refreshToken);
  }

  void close(String groupid) {
    websocketNotifier.removeChannel(groupid);
    isListening = false;
  }

  void listen(String groupId) {
    var token = authenticationProvider.accessToken;
    var groupChannel = websocketNotifier.createChannel(groupId, token);

    groupChannel.stream.listen(
      (event) {
        print(event);
        var handler = getWebSocketMessage(event);

        if (handler == null) {
          return;
        }

        handler.handle();
      },
      onDone: () {
        websocketNotifier.removeChannel(groupId);
        isListening = false;
      },
    );

    websocketNotifier.sendMessage(
        groupId, ConnectGroupWebSocketMessage(groupId), token);
  }
}
