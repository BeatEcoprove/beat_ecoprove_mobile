abstract class Notification {
  final String title;
  final String message;
  final Function(Notification) handle;

  Notification(
    this.title,
    this.message,
    this.handle,
  );
}
