import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/notification.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ViewModel {
  late BuildContext context;

  setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void showNotification(String message,
      {NotificationTypes type = NotificationTypes.info}) {
    final overlay = Overlay.of(context);
    final overlayKey = GlobalKey();
    NotificationWidget notification;

    switch (type) {
      case NotificationTypes.info:
        notification = NotificationWidget.info(
          key: overlayKey,
          message: message,
        );
        break;
      case NotificationTypes.error:
        notification = NotificationWidget.error(
          key: overlayKey,
          message: message,
        );
        break;
      case NotificationTypes.warning:
        notification = NotificationWidget.warning(
          key: overlayKey,
          message: message,
        );
        break;
      case NotificationTypes.success:
        notification = NotificationWidget.success(
          key: overlayKey,
          message: message,
        );
        break;
      default:
        notification = NotificationWidget.info(
          key: overlayKey,
          message: message,
        );
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 72,
        left: 16,
        right: 16,
        child: notification,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

enum NotificationTypes {
  info,
  error,
  warning,
  success,
}
