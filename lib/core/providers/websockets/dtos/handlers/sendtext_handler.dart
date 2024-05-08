import 'package:beat_ecoprove/core/providers/groups/group_borrowchat_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_group_borrow_message.dart';

class SendBorrowHandler extends Handler<WebsocketGroupBorrow> {
  final GroupManager groupManager;

  SendBorrowHandler(
    super.message,
    this.groupManager,
  );

  @override
  void handle() {
    groupManager.pushMessage(
      GroupBorrowChatMessage(
        message.groupId,
        message.message,
        message.ownerId,
        message.username,
        message.avatarPicture,
        message.type.toString(),
        message.clothAvatar,
        message.clothTitle,
        message.clothBrand,
        message.clothColor,
        message.clothSize,
        message.clothEcoScore,
        message.isAccepted,
      ),
    );
  }
}
