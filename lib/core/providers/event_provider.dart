import 'dart:async';

import 'package:flutter/material.dart';

abstract class IEvent {}

class ChangeWifiStatusEvent extends IEvent {
  final bool wifiOn;

  ChangeWifiStatusEvent(this.wifiOn);
}

abstract class IEventProvider {
  void setContext(BuildContext context);
  Stream<IEvent> get notifications;
  void sendNotification(IEvent notification);
}

class EventProvider implements IEventProvider {
  final _controller = StreamController<IEvent>.broadcast();

  @override
  void setContext(BuildContext context) {}

  @override
  Stream<IEvent> get notifications => _controller.stream;

  @override
  void sendNotification(IEvent notification) {
    _controller.add(notification);
  }

  void dispose() {
    _controller.close();
  }
}
