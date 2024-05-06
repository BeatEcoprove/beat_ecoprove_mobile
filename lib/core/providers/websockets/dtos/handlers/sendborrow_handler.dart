import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_group_message_message.dart';

class SendTextHandler extends Handler<WebsocketGroupMessage> {
  final GroupManager groupManager;

  SendTextHandler(
    super.message,
    this.groupManager,
  );

  @override
  void handle() {
    groupManager.pushMessage(GroupChatMessage(
      message.groupId,
      message.message,
      message.ownerId,
      message.username,
      message.avatarPicture,
      message.type.toString(),
    ));
  }
}
