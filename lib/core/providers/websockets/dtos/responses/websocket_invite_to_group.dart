import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketInviteToGroup extends WebsocketResult {
  final String message;
  final String code;
  final String groupId;
  final String invitorId;

  WebsocketInviteToGroup(Map<String, dynamic> json)
      : message = json['Message'],
        code = json['Code'],
        groupId = json['GroupId'],
        invitorId = json['InvitorId'],
        super.fromJson(json);
}
