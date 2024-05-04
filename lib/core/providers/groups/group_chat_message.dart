class GroupChatMessage {
  final String groupId;
  final String message;
  final String senderId;
  final String username;
  final String avatarPicture;
  final String type;

  GroupChatMessage(
    this.groupId,
    this.message,
    this.senderId,
    this.username,
    this.avatarPicture,
    this.type,
  );
}
