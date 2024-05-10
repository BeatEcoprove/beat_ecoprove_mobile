import 'package:beat_ecoprove/core/providers/groups/group_base_message.dart';

class GroupChatMessage extends GroupBaseMessage {
  final String content;
  final String username;
  final String avatarPicture;

  GroupChatMessage(
    super.messageId,
    super.groupId,
    this.content,
    super.senderId,
    this.username,
    this.avatarPicture,
    super.type,
  );
}
