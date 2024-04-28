import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_message_type.dart';

class WebsocketResult {
  final WebsocketMessageType type;
  final String ownerId;
  final DateTime createdAt;
  final DateTime deletedAt;

  WebsocketResult.fromJson(Map<String, dynamic> json)
      : type = WebsocketMessageType.getOf(json['Type']),
        ownerId = json['Owner'],
        createdAt = DateTime.parse(json['CreatedAt']),
        deletedAt = DateTime.parse(json['DeletedAt']);

  WebsocketResult.refactor({
    this.type = WebsocketMessageType.inviteToGroup,
    this.ownerId = '',
  })  : createdAt = DateTime.now(),
        deletedAt = DateTime.now();
}
