import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_form.dart';
import 'package:beat_ecoprove/group/presentation/create_group/create_group_view_model.dart';
import 'package:flutter/material.dart';

class CreateGroupView extends StatelessWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<CreateGroupViewModel>(),
        child: const CreateGroupForm());
  }
}
