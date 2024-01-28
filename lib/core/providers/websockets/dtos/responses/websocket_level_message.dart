import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketLevelMessage extends WebsocketResult {
  final String id;
  final int level;

  WebsocketLevelMessage(Map<String, dynamic> json)
      : id = json['Id'],
        level = json['Level'],
        super.fromJson(json);
}
