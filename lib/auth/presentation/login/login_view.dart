import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LoginViewModel(DependencyInjection.locator<LoginUseCase>()),
      child: const ApplicationBackground(content: LoginForm()),
    );
  }
}
