import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_form.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/group_chat_view_model.dart';
import 'package:flutter/material.dart';

class GroupChatView extends StatelessWidget {
  const GroupChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<GroupChatViewModel>(),
        child: const GroupChatForm());
  }
}
