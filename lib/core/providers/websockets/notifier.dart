import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_level_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'dart:convert' as convert;

abstract class Notifier extends ViewModel {
  WebsocketResult? getWebSocketMessage(String event) {
    var json = convert.jsonDecode(event);
    var result = WebsocketResult.fromJson(json);

    switch (result.type) {
      case WebsocketMessageType.levelUp:
        return WebsocketLevelMessage(json);
      default:
        return null;
    }
  }
}
