import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/acceptGroupConnectionHandler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/inviteToGroup_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/levelup_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/notify_borrow_request_accepted_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/sendborrow_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/sendtext_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_accept_group_connection_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_group_borrow_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_group_message_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_invite_to_group.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_level_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_notify_borrow_request_accepted_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';
import 'dart:convert' as convert;

import 'package:beat_ecoprove/group/services/group_service.dart';

abstract class Notifier {
  final LevelUpProvider levelUpProvider;
  final INotificationProvider notificationProvider;
  final NotificationManager notificationManager;
  final GroupManager groupManager;
  final GroupService groupService;

  Notifier(
    this.levelUpProvider,
    this.notificationProvider,
    this.notificationManager,
    this.groupManager,
    this.groupService,
  );

  Handler? getWebSocketMessage(String event) {
    var json = convert.jsonDecode(event);
    var result = WebsocketResult.fromJson(json);

    switch (result.type) {
      case WebsocketMessageType.levelUp:
        return LevelUpHandler(
          WebsocketLevelMessage(json),
          levelUpProvider,
        );
      case WebsocketMessageType.connectToGroup:
        return AcceptGroupConnectionHandler(
          WebsocketAcceptGroupConnectionMessage(json),
        );
      case WebsocketMessageType.inviteToGroup:
        return InviteToGroupHandler(
          WebsocketInviteToGroup(json),
          notificationProvider,
          notificationManager,
          groupService,
        );
      case WebsocketMessageType.chatTextMessage:
        return SendTextHandler(
          WebsocketGroupMessage(json),
          groupManager,
        );
      case WebsocketMessageType.borrowMessage:
        return SendBorrowHandler(
          WebsocketGroupBorrow(json),
          groupManager,
        );
      case WebsocketMessageType.notifyBorrowRequestAccepted:
        return NotifyBorrowRequestAcceptedHandler(
          WebsocketNotifyBorrowRequestAcceptedMessage(json),
          groupManager,
        );
      default:
        return null;
    }
  }
}
