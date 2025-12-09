import 'package:beat_ecoprove/core/providers/groups/group_borrowchat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/phoenix_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/phoenix_group_borrow_message.dart';

class PhoenixGroupBorrowHandler extends PhoenixHandler {
  final GroupManager groupManager;

  PhoenixGroupBorrowHandler(
    super.message,
    this.groupManager,
  );

  @override
  void handle() {
    if (message.isPhxEvent) {
      return;
    }

    try {
      final phoenixMessage =
          PhoenixGroupBorrowMessage.fromPhoenixMessage(message);

      final payload = message.payload;
      final garment = payload['garment'] ?? payload['cloth'] ?? {};

      groupManager.pushMessage(GroupBorrowChatMessage(
        phoenixMessage.messageId,
        phoenixMessage.groupId,
        phoenixMessage.memberId,
        message.event,
        phoenixMessage.createdAt ?? DateTime.now(),
        phoenixMessage.content,
        phoenixMessage.username,
        phoenixMessage.avatarPicture ?? '',
        garment['avatar']?.toString() ?? garment['image_url']?.toString() ?? '',
        garment['title']?.toString() ?? garment['name']?.toString() ?? '',
        garment['brand']?.toString() ?? '',
        garment['color']?.toString() ?? '',
        garment['size']?.toString() ?? '',
        garment['eco_score'] as int? ?? garment['ecoScore'] as int? ?? 0,
        false,
      ));
    } catch (e) {
      print(e.toString());
    }
  }
}
