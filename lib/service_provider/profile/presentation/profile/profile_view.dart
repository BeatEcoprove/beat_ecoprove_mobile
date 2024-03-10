import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_form.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class ServiceProviderProfileView extends StatelessWidget {
  const ServiceProviderProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel:
            DependencyInjection.locator<ServiceProviderProfileViewModel>(),
        child: const ServiceProviderProfileForm());
  }
}
