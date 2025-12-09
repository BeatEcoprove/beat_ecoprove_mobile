import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

class PhoenixGroupTextMessage {
  final String messageId;
  final String groupId;
  final String content;
  final String memberId;
  final String username;
  final String? avatarPicture;
  final DateTime? createdAt;
  final List<String> mentions;
  final String? replyTo;

  PhoenixGroupTextMessage.fromPhoenixMessage(PhoenixMessage message)
      : messageId = message.payload['id']?.toString() ?? '',
        groupId = message.payload['group_id']?.toString() ??
            _extractGroupIdFromTopic(message.topic),
        memberId = message.payload['sender_id']?.toString() ?? '',
        createdAt =
            DateTime.tryParse(message.payload['inserted_at'].toString()) ??
                DateTime.now(),
        content = message.payload['content']?.toString() ?? '',
        username = message.payload['username']?.toString() ?? '',
        avatarPicture = message.payload['avatar_picture']?.toString() ?? '',
        mentions = message.payload['mentions'] is List
            ? List<String>.from(message.payload['mentions'])
            : [],
        replyTo = message.payload['reply_to']?.toString() ?? '';

  static String _extractGroupIdFromTopic(String topic) {
    if (topic.startsWith('group:')) {
      return topic.substring(6);
    }
    return '';
  }
}
