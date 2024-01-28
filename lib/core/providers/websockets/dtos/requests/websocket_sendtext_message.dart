import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';

class SendTextWebSocketMessage extends WebSocketMessage {
  final String groupId;
  final String message;

  SendTextWebSocketMessage(this.groupId, this.message)
      : super(WebsocketMessageType.sendTextMessage.value);

  @override
  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'message': message,
      'type': type,
    };
  }
}
