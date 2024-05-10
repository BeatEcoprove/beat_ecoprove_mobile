import 'package:beat_ecoprove/core/providers/groups/group_borrow_accept_message.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_notify_borrow_request_accepted_message.dart';

class NotifyBorrowRequestAcceptedHandler
    extends Handler<WebsocketNotifyBorrowRequestAcceptedMessage> {
  final GroupManager groupManager;

  NotifyBorrowRequestAcceptedHandler(
    super.message,
    this.groupManager,
  );

  @override
  void handle() {
    groupManager.pushMessage(GroupBorrowAcceptMessage(
      message.groupId,
      message.ownerId,
      message.type.value,
      message.messageId,
      message.clothId,
      message.isAccepted,
    ));
  }
}
