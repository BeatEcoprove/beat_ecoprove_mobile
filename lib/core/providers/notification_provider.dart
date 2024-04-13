import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/notification.dart';
import 'package:flutter/material.dart';

abstract class INotificationProvider {
  setContext(BuildContext context);

  void showNotification(
    String message, {
    NotificationTypes type = NotificationTypes.info,
    Duration activeDuration = const Duration(seconds: 3),
  });
}

class NotificationProvider extends ViewModel implements INotificationProvider {
  late BuildContext context;

  @override
  setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  @override
  void showNotification(
    String message, {
    NotificationTypes type = NotificationTypes.info,
    Duration activeDuration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final overlayKey = GlobalKey();
    const animationDelay = Duration(milliseconds: 250);

    NotificationBanner notification;

    switch (type) {
      case NotificationTypes.info:
        notification = NotificationBanner.info(
          key: overlayKey,
          message: message,
          activeDuration: activeDuration,
          animationDelay: animationDelay,
        );

        break;
      case NotificationTypes.error:
        notification = NotificationBanner.error(
          key: overlayKey,
          message: message,
          activeDuration: activeDuration,
          animationDelay: animationDelay,
        );

        break;
      case NotificationTypes.warning:
        notification = NotificationBanner.warning(
          key: overlayKey,
          message: message,
          activeDuration: activeDuration,
          animationDelay: animationDelay,
        );

        break;
      case NotificationTypes.success:
        notification = NotificationBanner.success(
          key: overlayKey,
          message: message,
          activeDuration: activeDuration,
          animationDelay: animationDelay,
        );

        break;
      default:
        notification = NotificationBanner.info(
          key: overlayKey,
          message: message,
          activeDuration: activeDuration,
          animationDelay: animationDelay,
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
    Future.delayed(activeDuration + (animationDelay * 2) + Durations.short1,
        () {
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
