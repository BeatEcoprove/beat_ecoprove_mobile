import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_group_message_message.dart';

class WebsocketGroupBorrow extends WebsocketGroupMessage {
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;
  final String messageId;
  final bool isAccepted;

  WebsocketGroupBorrow(Map<String, dynamic> json)
      : clothAvatar = json['Content']['Borrow']['Avatar'],
        clothTitle = json['Content']['Borrow']['Title'],
        clothBrand = json['Content']['Borrow']['Brand'],
        clothColor = json['Content']['Borrow']['Color'],
        clothSize = json['Content']['Borrow']['Size'],
        clothEcoScore = int.parse(json['Content']['Borrow']['EcoScore']),
        messageId = json['Content']['Id'],
        isAccepted = json['Content']['IsAccepted'],
        super(json);
}
