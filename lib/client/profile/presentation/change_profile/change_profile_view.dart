import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_form.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view_model.dart';
import 'package:flutter/material.dart';

class ChangeProfileView extends StatelessWidget {
  const ChangeProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<ChangeProfileViewModel>(),
        child: const ChangeProfileForm());
  }
}
