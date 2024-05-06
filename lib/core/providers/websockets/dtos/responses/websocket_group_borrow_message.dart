import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_group_message_message.dart';

class WebsocketGroupBorrow extends WebsocketGroupMessage {
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;
  final String messageId;

  WebsocketGroupBorrow(Map<String, dynamic> json)
      : clothAvatar = json['Content']['borrow']['Avatar'],
        clothTitle = json['Content']['borrow']['Title'],
        clothBrand = json['Content']['borrow']['Brand'],
        clothColor = json['Content']['borrow']['Color'],
        clothSize = json['Content']['borrow']['Size'],
        clothEcoScore = int.parse(json['Content']['borrow']['EcoScore']),
        messageId = json['Content']['Id'],
        super(json);
}
