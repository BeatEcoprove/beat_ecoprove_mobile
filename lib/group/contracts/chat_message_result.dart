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

  // factory ChatMessageResult.fromJson(Map<String, dynamic> json) {
  //   return ChatMessageResult(
  //     json['id'],
  //     json['groupId'],
  //     json['content'],
  //     json['sender']['id'],
  //     json['sender']['username'],
  //     json['sender']['avatarUrl'],
  //     DateTime.parse(json['createdAt']),
  //   );
  // }

  factory ChatMessageResult.fromNewApi(
      Map<String, dynamic> item, String groupId) {
    final metadata = (item['metadata'] as Map?) ?? {};
    final payload = (item['payload'] as Map?) ?? {};

    final createdAtRaw =
        (item['inserted_at'] ?? item['created_at'])?.toString();

    return ChatMessageResult(
      item['id']?.toString() ?? '',
      groupId,
      payload['content']?.toString() ?? '',
      metadata['sender_id']?.toString() ?? '',
      '',
      '',
      createdAtRaw != null
          ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
