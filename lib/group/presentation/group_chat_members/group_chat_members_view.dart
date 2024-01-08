import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_form.dart';
import 'package:beat_ecoprove/group/presentation/group_chat_members/group_chat_members_view_model.dart';
import 'package:flutter/material.dart';

class GroupChatMembersView extends StatelessWidget {
  const GroupChatMembersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<GroupChatMembersViewModel>(),
        child: const GroupChatMembersForm());
  }
}
