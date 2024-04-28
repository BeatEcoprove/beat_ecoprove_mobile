import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
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
      "Novo Convite para um Grupo",
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
    try {
      await groupService.acceptMember(
          AcceptMemberOnGroupRequest(message.groupId, message.code));
    } on HttpBadRequestError catch (e) {
      notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    notificationManager.removeNotification(notification);
    notificationProvider.showNotification(
      "Entrou no grupo!",
      type: NotificationTypes.success,
    );
  }

  Future _handleDenied(InviteToGroupNotification notification) async {
    try {
      //TODO: CREATE SERVICE
    } on HttpBadRequestError catch (e) {
      notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    notificationManager.removeNotification(notification);
    notificationProvider.showNotification(
      "Cancelou o convite!",
      type: NotificationTypes.success,
    );
  }
}
