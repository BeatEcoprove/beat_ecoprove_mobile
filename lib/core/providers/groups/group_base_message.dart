abstract class GroupBaseMessage {
  final String messageId;
  final String groupId;
  final String senderId;
  final String type;
  final DateTime createdAt;

  GroupBaseMessage(
    this.messageId,
    this.groupId,
    this.senderId,
    this.type,
    this.createdAt,
  );
}
