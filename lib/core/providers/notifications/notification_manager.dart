import 'package:beat_ecoprove/core/providers/notifications/notification.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class NotificationManager extends ViewModel {
  final List<Notification> notifications = [];
  late String oi = "oi";

  void addNotification(Notification notification) {
    notifications.add(notification);
    oi = "desoi";
    notifyListeners();
  }

  void removeNotification(Notification notification) {
    notifications.remove(notification);
    notifyListeners();
  }

  T getNotification<T extends Notification>() {
    return notifications.firstWhere((notification) {
      return notification is T;
    }) as T;
  }

  int get notificationsCount => notifications.length;
}
