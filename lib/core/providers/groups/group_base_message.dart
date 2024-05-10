abstract class GroupBaseMessage {
  final String messageId;
  final String groupId;
  final String senderId;
  final String type;
  final DateTime createdAt;

  GroupBaseMessage(
    this.groupId,
    this.senderId,
    this.type,
    this.messageId,
  ) : createdAt = DateTime.now();
}
