import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class GroupManager extends ViewModel {
  final List<GroupChatMessage> messages = [];

  addAllMessages(List<GroupChatMessage> messages) {
    this.messages.addAll(messages);
    notifyListeners();
  }

  void addMessage(GroupChatMessage message) {
    messages.add(message);
    notifyListeners();
  }

  void removeMessage(GroupChatMessage notification) {
    messages.remove(notification);
    notifyListeners();
  }

  T getMessage<T extends GroupChatMessage>() {
    return messages.firstWhere((notification) {
      return notification is T;
    }) as T;
  }
}
