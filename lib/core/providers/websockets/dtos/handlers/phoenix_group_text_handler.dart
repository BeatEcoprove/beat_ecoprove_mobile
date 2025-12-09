import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/phoenix_handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/phoenix_group_text_message.dart';

class PhoenixGroupTextHandler extends PhoenixHandler {
  final GroupManager groupManager;

  PhoenixGroupTextHandler(
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
          PhoenixGroupTextMessage.fromPhoenixMessage(message);

      groupManager.pushMessage(GroupChatMessage(
        phoenixMessage.messageId,
        phoenixMessage.groupId,
        phoenixMessage.memberId,
        message.event,
        phoenixMessage.createdAt ?? DateTime.now(),
        phoenixMessage.content,
        phoenixMessage.username,
        phoenixMessage.avatarPicture ?? '',
      ));
    } catch (e) {
      print(e.toString());
    }
  }
}
