import 'package:beat_ecoprove/group/contracts/chat_borrow_result.dart';
import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatMessages {
  List<ChatMessageResult> messages;

  ChatMessages(
    this.messages,
  );

  factory ChatMessages.fromApi(Map<String, dynamic> response, String groupId) {
    final List<dynamic> data = (response['data'] as List?) ?? [];

    final results = data.map((item) {
      final type = (item['type'] ?? '').toString();
      switch (type) {
        case 'borrow':
          return ChatBorrowResult.fromNewApi(item, groupId);
        case 'text':
        default:
          return ChatMessageResult.fromNewApi(item, groupId);
      }
    }).toList();

    return ChatMessages(results);
  }
}
