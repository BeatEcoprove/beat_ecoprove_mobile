import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';

class GroupBorrowChatMessage extends GroupChatMessage {
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;
  final bool isAccepted;

  GroupBorrowChatMessage(
    super.messageId,
    super.groupId,
    super.message,
    super.senderId,
    super.username,
    super.avatarPicture,
    super.type,
    this.clothAvatar,
    this.clothTitle,
    this.clothBrand,
    this.clothColor,
    this.clothSize,
    this.clothEcoScore,
    this.isAccepted,
  );
}
