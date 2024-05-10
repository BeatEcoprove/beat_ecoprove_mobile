import 'dart:collection';

import 'package:beat_ecoprove/core/providers/groups/group_base_message.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class GroupManager extends ViewModel {
  final Queue<GroupBaseMessage> messages = Queue();

  void pushMessage(GroupBaseMessage message) {
    messages.add(message);
    notifyListeners();
  }

  void dropLast(GroupBaseMessage notification) {
    messages.remove(notification);
    notifyListeners();
  }

  T getMessage<T extends GroupBaseMessage>() {
    return messages.removeFirst() as T;
  }
}
