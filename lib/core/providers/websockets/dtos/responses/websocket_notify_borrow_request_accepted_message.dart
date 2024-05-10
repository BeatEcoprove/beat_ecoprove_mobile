import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketNotifyBorrowRequestAcceptedMessage extends WebsocketResult {
  final String messageId;
  final String groupId;
  final String clothId;
  final bool isAccepted;

  WebsocketNotifyBorrowRequestAcceptedMessage(Map<String, dynamic> json)
      : messageId = json['Content']['MessageId'],
        groupId = json['Content']['GroupId'],
        clothId = json['Content']['ClothId'],
        isAccepted = bool.tryParse(json['Content']['MessageId']) ?? false,
        super.fromJson(json);
}
