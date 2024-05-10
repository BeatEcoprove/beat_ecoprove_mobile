import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatBorrowResult extends ChatMessageResult {
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;
  final bool isAccepted;

  ChatBorrowResult(
    super.messageId,
    super.groupId,
    super.content,
    this.clothAvatar,
    this.clothTitle,
    this.clothBrand,
    this.clothColor,
    this.clothSize,
    this.clothEcoScore,
    super.senderId,
    super.username,
    super.avatarPicture,
    super.createdAt,
    this.isAccepted,
  );

  factory ChatBorrowResult.fromJson(Map<String, dynamic> json) {
    return ChatBorrowResult(
        json['id'],
        json['groupId'],
        json['content'],
        json['borrow']['clothAvatar'],
        json['borrow']['name'],
        json['borrow']['brand'],
        json['borrow']['color'],
        json['borrow']['size'],
        int.parse(json['borrow']['ecoScore']),
        json['sender']['id'],
        json['sender']['username'],
        json['sender']['avatarUrl'],
        DateTime.parse(json['createdAt']),
        json['isAccepted']);
  }
}
