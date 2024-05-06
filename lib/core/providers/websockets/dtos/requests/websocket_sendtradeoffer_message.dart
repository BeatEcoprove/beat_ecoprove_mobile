import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';

class SendTradeOfferWebSocketMessage extends WebSocketMessage {
  final String groupId;
  final String message;
  final String clothId;

  SendTradeOfferWebSocketMessage(this.groupId, this.message, this.clothId)
      : super(WebsocketMessageType.sendTradeOfferMessage.value);

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();

    json.addAll({
      'groupId': groupId,
      'message': message,
      'clothId': clothId,
    });

    return json;
  }
}
