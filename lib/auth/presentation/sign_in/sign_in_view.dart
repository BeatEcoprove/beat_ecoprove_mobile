import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_view_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  static const double headerGap = 36;

  final SignUserType? userType;

  const SignInView({this.userType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<SignInViewModel>(),
      child: Scaffold(
        body: SignInViewController(
          sections: userType != null ? userType!.sections : [],
        ),
      ),
    );
  }
}
