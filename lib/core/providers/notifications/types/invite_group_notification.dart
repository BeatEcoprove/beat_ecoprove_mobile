import 'package:beat_ecoprove/core/providers/notifications/notification.dart';

class InviteToGroupNotification extends Notification {
  final String code;
  final String groupId;
  final String invitorId;

  InviteToGroupNotification(
      super.title, super.message, this.code, this.groupId, this.invitorId);
}
