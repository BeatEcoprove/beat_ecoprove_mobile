import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketLevelMessage extends WebsocketResult {
  final int level;
  final int xp;
  final String message;

  WebsocketLevelMessage(Map<String, dynamic> json)
      : level = json['Content']['Level'],
        xp = json['Content']['Xp'],
        message = json['Content']['Message'],
        super.fromJson(json);
}
