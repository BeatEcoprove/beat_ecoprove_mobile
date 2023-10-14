import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ApplicationBackground(content: LoginForm());
  }
}
