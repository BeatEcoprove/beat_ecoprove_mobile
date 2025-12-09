import 'package:beat_ecoprove/client/profile/services/profile_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatBorrowResult extends ChatMessageResult {
  final String clothAvatar;
  final String clothTitle;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;
  final bool isAccepted;

  ChatBorrowResult(
    super.messageId,
    super.groupId,
    super.content,
    this.clothAvatar,
    this.clothTitle,
    this.clothBrand,
    this.clothColor,
    this.clothSize,
    this.clothEcoScore,
    super.senderId,
    super.username,
    super.avatarPicture,
    super.createdAt,
    this.isAccepted,
  );

  static Future<ChatBorrowResult> fromNewApi(
      Map<String, dynamic> item, String groupId) async {
    final metadata = (item['metadata'] as Map?) ?? {};
    final payload = (item['payload'] as Map?) ?? {};

    final createdAtRaw =
        (item['inserted_at'] ?? item['created_at'])?.toString();

    final senderId = metadata['sender_id']?.toString() ?? '';

    final senderData = await DependencyInjection.locator<ProfileService>()
        .getProfileDataById([senderId]);

    return ChatBorrowResult(
      item['id']?.toString() ?? '',
      groupId,
      payload['content']?.toString() ?? '',
      payload['cloth_avatar']?.toString() ?? '',
      payload['cloth_title']?.toString() ?? '',
      payload['cloth_brand']?.toString() ?? '',
      payload['cloth_color']?.toString() ?? '',
      payload['cloth_size']?.toString() ?? '',
      payload['cloth_eco_score'] ?? 0,
      senderId,
      senderData.profiles.first.username,
      senderData.profiles.first.avatarUrl,
      createdAtRaw != null
          ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
          : DateTime.now(),
      payload['is_accepted'] ?? false,
    );
  }
}
