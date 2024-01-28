import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/levelup_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_level_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'dart:convert' as convert;

abstract class Notifier extends ViewModel {
  final LevelUpProvider levelUpProvider;

  Notifier(this.levelUpProvider);

  Handler? getWebSocketMessage(String event) {
    var json = convert.jsonDecode(event);
    var result = WebsocketResult.fromJson(json);

    switch (result.type) {
      case WebsocketMessageType.levelUp:
        return LevelUpHandler(WebsocketLevelMessage(json), levelUpProvider);
      default:
        return null;
    }
  }
}
