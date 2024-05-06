class GroupChatMessage {
  final String groupId;
  final String content;
  final String senderId;
  final String username;
  final String avatarPicture;
  final String type;
  final DateTime createdAt;

  GroupChatMessage(
    this.groupId,
    this.content,
    this.senderId,
    this.username,
    this.avatarPicture,
    this.type,
  ) : createdAt = DateTime.now();
}
