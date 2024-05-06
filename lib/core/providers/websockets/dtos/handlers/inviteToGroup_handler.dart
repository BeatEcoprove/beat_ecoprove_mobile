import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/notifications/types/invite_group_notification.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_invite_to_group.dart';
import 'package:beat_ecoprove/group/contracts/accept_member_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class InviteToGroupHandler extends Handler<WebsocketInviteToGroup> {
  final INotificationProvider notificationProvider;
  final NotificationManager notificationManager;
  final GroupService groupService;

  InviteToGroupHandler(
    super.message,
    this.notificationProvider,
    this.notificationManager,
    this.groupService,
  );

  @override
  void handle() {
    notificationProvider.showNotification(message.message);
    notificationManager.addNotification(InviteToGroupNotification(
      '',
      message.message,
      (notification) async =>
          await _handleAccept(notification as InviteToGroupNotification),
      (notification) async =>
          await _handleDenied(notification as InviteToGroupNotification),
      message.code,
      message.groupId,
      message.fromId,
    ));
  }

  Future _handleAccept(InviteToGroupNotification notification) async {
    await groupService.acceptMember(
        AcceptMemberOnGroupRequest(message.groupId, message.code));
    notificationManager.removeNotification(notification);
  }

  Future _handleDenied(InviteToGroupNotification notification) async {
    await groupService.deniedMember(
        AcceptMemberOnGroupRequest(message.groupId, message.code));
    notificationManager.removeNotification(notification);
  }
}
