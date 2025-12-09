import 'dart:convert' as convert;
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/phoenix_group_borrow_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/phoenix_group_text_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/phoenix_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

abstract class PhoenixNotifier {
  final LevelUpProvider levelUpProvider;
  final INotificationProvider notificationProvider;
  final NotificationManager notificationManager;
  final GroupManager groupManager;
  final GroupService groupService;

  PhoenixNotifier(
    this.levelUpProvider,
    this.notificationProvider,
    this.notificationManager,
    this.groupManager,
    this.groupService,
  );

  PhoenixHandler? getPhoenixMessage(String event) {
    try {
      final json = convert.jsonDecode(event);
      final phoenixMessage = PhoenixMessage.fromJson(json);

      if (phoenixMessage.isPhxEvent && phoenixMessage.event != 'new_msg') {
        return null;
      }

      final topic = phoenixMessage.topic;
      final eventType = phoenixMessage.event;

      if (topic.startsWith('group:')) {
        if (eventType == 'recived_message') {
          final payload = phoenixMessage.payload;
          final type = (payload['type'] ?? '').toString();

          if (type == 'borrow') {
            return PhoenixGroupBorrowHandler(phoenixMessage, groupManager);
          }

          return PhoenixGroupTextHandler(phoenixMessage, groupManager);
        }

        if (eventType == 'send_text_msg') {
          return PhoenixGroupTextHandler(phoenixMessage, groupManager);
        }

        if (eventType == 'send_borrow_msg') {
          return PhoenixGroupBorrowHandler(phoenixMessage, groupManager);
        }
      } else if (topic.startsWith('notification:')) {
        // TODO: Implementar handlers de notificação
        // return PhoenixNotificationHandler(phoenixMessage, notificationProvider, notificationManager);
      }

      return null;
    } catch (e) {
      print('Error processing Phoenix message: $e');
      return null;
    }
  }
}
