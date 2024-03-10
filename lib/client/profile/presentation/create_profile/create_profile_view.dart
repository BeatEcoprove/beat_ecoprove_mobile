import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_form.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_view_model.dart';
import 'package:flutter/material.dart';

class CreateProfileView extends StatelessWidget {
  const CreateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<CreateProfileViewModel>(),
        child: const CreateProfileForm());
  }
}
