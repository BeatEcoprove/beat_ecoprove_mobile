import 'package:beat_ecoprove/group/contracts/chat_borrow_result.dart';
import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatMessages {
  List<ChatMessageResult> messages;

  ChatMessages(
    this.messages,
  );

  static Future<ChatMessages> fromApi(
      Map<String, dynamic> response, String groupId) async {
    final List<dynamic> data = (response['data'] as List?) ?? [];

    final futures = data.map((item) async {
      final type = (item['type'] ?? '').toString();
      try {
        switch (type) {
          case 'borrow':
            return await ChatBorrowResult.fromNewApi(item, groupId);
          case 'text':
          default:
            return await ChatMessageResult.fromNewApi(item, groupId);
        }
      } catch (e) {
        print(e.toString());
        rethrow;
      }
    }).toList();

    final results = await Future.wait(futures);
    return ChatMessages(results);
  }
}
