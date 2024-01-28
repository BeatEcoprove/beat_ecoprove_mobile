import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_form.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view_model.dart';
import 'package:flutter/material.dart';

class UpdateGroupParams {
  final List<String> adminId;
  final GroupDetailsResult group;

  UpdateGroupParams({
    required this.adminId,
    required this.group,
  });
}

class EditGroupView extends StatelessWidget {
  final UpdateGroupParams params;

  const EditGroupView({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<EditGroupViewModel>(),
        child: EditGroupForm(
          param: params,
        ));
  }
}
