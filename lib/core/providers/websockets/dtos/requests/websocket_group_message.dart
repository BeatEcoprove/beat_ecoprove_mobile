import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message.dart';

class ConnectGroupWebSocketMessage extends WebSocketMessage {
  final String groupId;

  ConnectGroupWebSocketMessage(this.groupId) : super('connectToGroup');

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'groupId': groupId,
    };
  }
}
