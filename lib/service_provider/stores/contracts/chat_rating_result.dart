import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatRatingResult extends ChatMessageResult {
  final double rating;

  ChatRatingResult(
    super.messageId,
    super.groupId,
    super.content,
    this.rating,
    super.senderId,
    super.username,
    super.avatarPicture,
    super.createdAt,
  );

  factory ChatRatingResult.fromJson(Map<String, dynamic> json) {
    return ChatRatingResult(
      json['id'],
      json['groupId'],
      '',
      double.parse(json['rating']),
      json['sender']['id'],
      json['sender']['username'],
      json['sender']['avatarUrl'],
      DateTime.parse(json['createdAt']),
    );
  }
}
