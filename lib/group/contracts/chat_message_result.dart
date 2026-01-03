import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class ChatMessageResult {
  final String messageId;
  final String groupId;
  final String content;
  final String senderId;
  final String username;
  final String avatarPicture;
  final DateTime createdAt;

  ChatMessageResult(
    this.messageId,
    this.groupId,
    this.content,
    this.senderId,
    this.username,
    this.avatarPicture,
    this.createdAt,
  );

  static Future<ChatMessageResult> fromNewApi(
      Map<String, dynamic> item, String groupId) async {
    final metadata = (item['metadata'] as Map?) ?? {};
    final payload = (item['payload'] as Map?) ?? {};

    final createdAtRaw = item['inserted_at']?.toString();

    final senderId = metadata['sender_id']?.toString() ?? '';

    final senderData = await DependencyInjection.locator<ProfileService>()
        .getProfileDataById([senderId]);

    return ChatMessageResult(
      item['id']?.toString() ?? '',
      groupId,
      payload['content']?.toString() ?? '',
      senderId,
      senderData.profiles.first.username,
      senderData.profiles.first.avatarUrl,
      createdAtRaw != null
          ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
