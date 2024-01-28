import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/notifications/types/invite_group_notification.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_invite_to_group.dart';

class InviteToGroupHandler extends Handler<WebsocketInviteToGroup> {
  final NotificationProvider notificationProvider;
  final NotificationManager notificationManager;

  InviteToGroupHandler(
      super.message, this.notificationProvider, this.notificationManager);

  @override
  void handle() {
    notificationProvider.showNotification(message.message);
    notificationManager.addNotification(InviteToGroupNotification(
        "Novo Convite para um Grupo",
        message.message,
        message.code,
        message.groupId,
        message.invitorId));
  }
}
