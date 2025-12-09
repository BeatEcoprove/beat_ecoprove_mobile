class EnrichedGroupChatMessage {
  final String messageId;
  final String senderId;
  final String content;
  final DateTime createdAt;
  final String groupId;
  final String type;
  final String username;
  final String avatarPicture;

  EnrichedGroupChatMessage({
    required this.messageId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.groupId,
    required this.type,
    required this.username,
    required this.avatarPicture,
  });
}

class EnrichedGroupBorrowChatMessage {
  final String messageId;
  final String senderId;
  final String content;
  final DateTime createdAt;
  final String groupId;
  final String type;
  final String username;
  final String avatarPicture;
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;

  EnrichedGroupBorrowChatMessage({
    required this.messageId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.groupId,
    required this.type,
    required this.username,
    required this.avatarPicture,
    required this.clothAvatar,
    required this.clothTitle,
    required this.clothBrand,
    required this.clothColor,
    required this.clothSize,
    required this.clothEcoScore,
  });
}
