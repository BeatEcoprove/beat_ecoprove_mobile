import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/inviteToGroup_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/levelup_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_invite_to_group.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_level_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';
import 'dart:convert' as convert;

abstract class Notifier {
  final LevelUpProvider levelUpProvider;
  final NotificationProvider notificationProvider;
  final NotificationManager notificationManager;

  Notifier(
    this.levelUpProvider,
    this.notificationProvider,
    this.notificationManager,
  );

  Handler? getWebSocketMessage(String event) {
    var json = convert.jsonDecode(event);
    var result = WebsocketResult.fromJson(json);

    switch (result.type) {
      case WebsocketMessageType.levelUp:
        return LevelUpHandler(WebsocketLevelMessage(json), levelUpProvider);
      case WebsocketMessageType.inviteToGroup:
        return InviteToGroupHandler(WebsocketInviteToGroup(json),
            notificationProvider, notificationManager);
      default:
        return null;
    }
  }
}
