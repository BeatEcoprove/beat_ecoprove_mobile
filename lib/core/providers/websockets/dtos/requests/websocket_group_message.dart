import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message.dart';

class ConnectGroupWebSocketMessage extends WebSocketMessage {
  final String groupId;

  ConnectGroupWebSocketMessage(this.groupId) : super('ConnectGroupEvent');

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json.addAll({"groupId": groupId});

    return json;
  }
}
