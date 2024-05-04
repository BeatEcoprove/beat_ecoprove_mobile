import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketGroupMessage extends WebsocketResult {
  final String groupId;
  final String message;
  final String memberId;
  final String username;
  final String avatarPicture;

  WebsocketGroupMessage(Map<String, dynamic> json)
      : groupId = json['Content']['Group'],
        message = json['Content']['Message'],
        memberId = json['Content']['Member']['Id'],
        username = json['Content']['Member']['Username'],
        avatarPicture = json['Content']['Member']['AvatarPicture'],
        super.fromJson(json);
}
