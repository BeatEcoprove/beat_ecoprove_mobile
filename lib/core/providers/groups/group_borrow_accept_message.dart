import 'package:beat_ecoprove/core/providers/groups/group_base_message.dart';

class GroupBorrowAcceptMessage extends GroupBaseMessage {
  final String clothId;
  final bool isAccepted;

  GroupBorrowAcceptMessage(
    super.groupId,
    super.senderId,
    super.type,
    super.messageId,
    this.clothId,
    this.isAccepted,
  );
}
