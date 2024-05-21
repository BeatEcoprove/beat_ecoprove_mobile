import 'package:beat_ecoprove/group/contracts/chat_borrow_result.dart';
import 'package:beat_ecoprove/group/contracts/chat_message_result.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/chat_rating_result.dart';

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
      var {"type": type} = item;
      switch (type) {
        case "MessageResult":
          return ChatMessageResult.fromJson(item);

        case "BorrowMessageResult":
          return ChatBorrowResult.fromJson(item);

        case "RatingMessageResult":
          return ChatRatingResult.fromJson(item);

        default:
          return ChatMessageResult.fromJson(item);
      }
    }).toList();
    return group;
  }
}
