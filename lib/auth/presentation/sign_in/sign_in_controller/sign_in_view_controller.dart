import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_wrapper.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:flutter/material.dart';

class SignInViewController extends StatefulWidget {
  static const double signViewHeaderGap = 200;

  final SignUserType type;

  const SignInViewController({required this.type, Key? key}) : super(key: key);

  @override
  State<SignInViewController> createState() => _SignInViewControllerState();
}

class _SignInViewControllerState extends State<SignInViewController> {
  @override
  Widget build(BuildContext context) {
    var sections = widget.type.sections;

    var signViewModel = ViewModel.of<SignInViewModel>(context);
    var signInController =
        SignInController(sections, signViewModel, widget.type);

    return ViewModelProvider(
      viewModel: signInController,
      child: SignInWrapper(sections: sections),
    );
  }
}
