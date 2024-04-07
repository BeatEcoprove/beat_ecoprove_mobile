import 'dart:collection';

import 'package:beat_ecoprove/core/providers/groups/group_chat_message.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class GroupManager extends ViewModel {
  final Queue<GroupChatMessage> messages = Queue();

  void pushMessage(GroupChatMessage message) {
    messages.add(message);
    notifyListeners();
  }

  void dropLast(GroupChatMessage notification) {
    messages.remove(notification);
    notifyListeners();
  }

  T getMessage<T extends GroupChatMessage>() {
    return messages.removeFirst() as T;
  }
}
