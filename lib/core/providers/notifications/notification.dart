abstract class GroupNotification {
  final String title;
  final String message;
  final Function(GroupNotification) handleAccept;
  final Function(GroupNotification) handleDenied;

  GroupNotification(
    this.title,
    this.message,
    this.handleAccept,
    this.handleDenied,
  );
}
