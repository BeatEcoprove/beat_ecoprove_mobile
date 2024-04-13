import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_view_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:flutter/material.dart';

class SignInViewParams {
  SignUseroptions userType;

  SignInViewParams(this.userType);
}

class SignInView extends ArgumentView<SignInViewModel, SignInViewParams> {
  static const double headerGap = 36;

  const SignInView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, SignInViewModel viewModel) {
    var controller = SignInController(
      args.userType,
      viewModel,
    );

    return Scaffold(
      body: SignInViewController(
        viewModel: controller,
        args: args.userType,
      ),
    );
  }
}
