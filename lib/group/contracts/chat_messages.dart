import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';

class ChatMessages {
  List<ChatMessageResult> messages;

  ChatMessages(
    this.messages,
  );

  factory ChatMessages.fromJson(List<dynamic> json) {
    return ChatMessages(
      _convertJsonToChatMessageResult(json),
    );
  }

  static List<ChatMessageResult> _convertJsonToChatMessageResult(
      List<dynamic> groups) {
    var group = groups.map((item) {
      return ChatMessageResult.fromJson(item);
    }).toList();
    return group;
  }
}
