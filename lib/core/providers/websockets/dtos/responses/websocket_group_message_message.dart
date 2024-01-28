import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketGroupMessage extends WebsocketResult {
  final String groupId;
  final String content;
  final String username;
  final String avatarPicture;

  WebsocketGroupMessage(Map<String, dynamic> json)
      : groupId = json['GroupId'],
        content = json['Content'],
        username = json['UserName'],
        avatarPicture = json['AvatarPicture'],
        super.fromJson(json);
}
