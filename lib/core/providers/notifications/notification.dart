abstract class GroupNotification {
  final String title;
  final String message;
  final Function(GroupNotification) handle;

  GroupNotification(
    this.title,
    this.message,
    this.handle,
  );
}
