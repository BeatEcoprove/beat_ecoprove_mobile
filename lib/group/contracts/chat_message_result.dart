class ChatMessageResult {
  final String messageId;
  final String groupId;
  final String content;
  final String senderId;
  final String username;
  final String avatarPicture;
  final DateTime createdAt;

  ChatMessageResult(
    this.messageId,
    this.groupId,
    this.content,
    this.senderId,
    this.username,
    this.avatarPicture,
    this.createdAt,
  );

  factory ChatMessageResult.fromJson(Map<String, dynamic> json) {
    return ChatMessageResult(
      json['id'],
      json['groupId'],
      json['content'],
      json['sender']['id'],
      json['sender']['username'],
      json['sender']['avatarUrl'],
      DateTime.parse(json['createdAt']),
    );
  }
}
