import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatRatingMessageResult extends ChatMessageResult {
  final double rating;

  ChatRatingMessageResult(
    super.messageId,
    super.groupId,
    super.content,
    this.rating,
    super.senderId,
    super.username,
    super.avatarPicture,
    super.createdAt,
  );

  factory ChatRatingMessageResult.fromJson(Map<String, dynamic> json) {
    return ChatRatingMessageResult(
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

class ChatRatingResult {
  final String storeId;
  final double rating;
  final String senderId;
  final String username;
  final String avatarPicture;

  ChatRatingResult(
    this.storeId,
    this.rating,
    this.senderId,
    this.username,
    this.avatarPicture,
  );

  factory ChatRatingResult.fromJson(Map<String, dynamic> json) {
    dynamic rating = json['rating'];
    if (rating is int) {
      rating = rating.toDouble();
    }

    return ChatRatingResult(
      json['storeId'],
      rating,
      json['owner']['id'],
      json['owner']['username'],
      json['owner']['avatarUrl'],
    );
  }
}
