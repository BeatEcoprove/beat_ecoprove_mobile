import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelProvider(
      viewModel: DependencyInjection.locator<LoginViewModel>(),
      child: const ApplicationBackground(content: LoginForm()),
    ));
  }
}
