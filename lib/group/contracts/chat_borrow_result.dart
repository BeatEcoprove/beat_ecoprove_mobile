import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatBorrowResult extends ChatMessageResult {
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;

  ChatBorrowResult(
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
  );

  factory ChatBorrowResult.fromJson(Map<String, dynamic> json) {
    return ChatBorrowResult(
      json['groupId'],
      json['message'],
      json['borrow']['avatar'],
      json['borrow']['title'],
      json['borrow']['brand'],
      json['borrow']['color'],
      json['borrow']['size'],
      json['borrow']['ecoScore'],
      json['sender']['id'],
      json['sender']['username'],
      json['sender']['avatarUrl'],
      DateTime.parse(json['createdAt']),
    );
  }
}
