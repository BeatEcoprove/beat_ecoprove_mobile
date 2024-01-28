import 'package:beat_ecoprove/core/providers/notifications/notification.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class NotificationManager extends ViewModel {
  final List<Notification> _notifications = [];

  void addNotification(Notification notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void removeNotification(Notification notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

  T getNotification<T extends Notification>() {
    return _notifications.firstWhere((notification) {
      return notification is T;
    }) as T;
  }

  List<Notification> get notifications => _notifications;
  int get notificationsCount => _notifications.length;
}
