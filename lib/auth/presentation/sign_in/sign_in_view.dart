import 'package:beat_ecoprove/auth/presentation/sign_in/stages/first_stage.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  static const double headerGap = 36;

  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoBack(goBackPath: "/select-user", child: FirstStage()),
    );
  }
}
