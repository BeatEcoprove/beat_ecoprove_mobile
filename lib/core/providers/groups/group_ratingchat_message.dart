import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';

class GroupRatingChatMessage extends GroupChatMessage {
  final double rating;

  GroupRatingChatMessage(
    super.messageId,
    super.groupId,
    super.message,
    super.senderId,
    super.username,
    super.avatarPicture,
    super.type,
    this.rating,
  );
}
