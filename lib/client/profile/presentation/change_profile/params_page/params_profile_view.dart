import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_form.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_view_model.dart';
import 'package:flutter/material.dart';

class ParamsProfileView extends StatelessWidget {
  final String params;

  const ParamsProfileView({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: DependencyInjection.locator<ParamsProfileViewModel>(),
        child: ParamsProfileForm(
          params: params,
        ));
  }
}
