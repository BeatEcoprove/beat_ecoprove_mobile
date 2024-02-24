import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketAcceptGroupConnectionMessage extends WebsocketResult {
  final String groupId;
  final String message;

  WebsocketAcceptGroupConnectionMessage(Map<String, dynamic> json)
      : groupId = json['Content']['Group'],
        message = json['Content']['Message'],
        super.fromJson(json);
}
