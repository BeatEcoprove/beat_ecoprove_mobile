import 'package:beat_ecoprove/core/domain/models/group_item.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_form.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:flutter/material.dart';

class GroupChatView extends StatelessWidget {
  final GroupItem groupItem;

  const GroupChatView({
    Key? key,
    required this.groupItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DependencyInjection.locator<IWCNotifier>().enterGroup(groupItem.id);

    return ViewModelProvider(
        viewModel: DependencyInjection.locator<GroupChatViewModel>(),
        child: GroupChatForm(
          groupItem: groupItem,
        ));
  }
}
