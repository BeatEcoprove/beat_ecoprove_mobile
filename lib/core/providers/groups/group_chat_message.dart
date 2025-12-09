import 'package:beat_ecoprove/core/providers/groups/group_base_message.dart';

class GroupChatMessage extends GroupBaseMessage {
  final String content;
  final String username;
  final String avatarPicture;

  GroupChatMessage(
    super.messageId,
    super.groupId,
    super.senderId,
    super.type,
    super.createdAt,
    this.content,
    this.username,
    this.avatarPicture,
  );
}
