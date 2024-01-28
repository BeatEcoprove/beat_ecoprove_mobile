import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';

class WebsocketResult {
  final WebsocketMessageType type;

  WebsocketResult.fromJson(Map<String, dynamic> json)
      : type = WebsocketMessageType.getOf(json['Type']);
}
