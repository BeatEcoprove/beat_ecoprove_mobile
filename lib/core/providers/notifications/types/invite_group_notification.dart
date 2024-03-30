import 'package:beat_ecoprove/core/providers/notifications/notification.dart';

class InviteToGroupNotification extends GroupNotification {
  final String code;
  final String groupId;
  final String invitorId;

  InviteToGroupNotification(super.title, super.message, super.handle, this.code,
      this.groupId, this.invitorId);
}
