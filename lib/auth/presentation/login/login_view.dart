import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return const ApplicationBackground(
        content: Center(
      child: Padding(padding: EdgeInsets.all(60), child: LoginForm()),
    ));
  }
}
