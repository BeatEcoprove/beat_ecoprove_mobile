import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_wrapper.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';

class SignInViewController
    extends ArgumentedView<SignInController, SignUseroptions> {
  static const double signViewHeaderGap = 200;

  const SignInViewController({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, SignInController viewModel) {
    return SignInWrapper(
      sections: viewModel.sections,
    );
  }
}
