import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

class WebsocketInviteToGroup extends WebsocketResult {
  final String message;
  final String code;
  final String groupId;
  final String groupName;
  final String fromId;

  WebsocketInviteToGroup(Map<String, dynamic> json)
      : message = json['Content']['Message'],
        code = json['Content']['Code'],
        groupId = json['Content']['Group'],
        groupName = json['Content']['GroupName'],
        fromId = json['Content']['From'],
        super.fromJson(json);

  WebsocketInviteToGroup.refactor(Map<String, dynamic> json)
      : message = json['title'],
        code = json['code'],
        groupId = json['groupId'],
        groupName = json['groupName'],
        fromId = json['invitorId'],
        super.refactor();
}
