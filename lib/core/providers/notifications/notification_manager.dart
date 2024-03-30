import 'package:beat_ecoprove/core/providers/notifications/notification.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class NotificationManager extends ViewModel {
  final List<GroupNotification> notifications = [];

  void addNotification(GroupNotification notification) {
    notifications.add(notification);
    notifyListeners();
  }

  void removeNotification(GroupNotification notification) {
    notifications.remove(notification);
    notifyListeners();
  }

  T getNotification<T extends GroupNotification>() {
    return notifications.firstWhere((notification) {
      return notification is T;
    }) as T;
  }

  int get notificationsCount => notifications.length;
}
