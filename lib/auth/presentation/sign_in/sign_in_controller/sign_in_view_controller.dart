import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:flutter/material.dart';

class SignInViewController extends StatefulWidget {
  final List<Widget> sections;

  const SignInViewController({required this.sections, Key? key})
      : super(key: key);

  @override
  State<SignInViewController> createState() => _SignInViewControllerState();
}

class _SignInViewControllerState extends State<SignInViewController> {
  late SignInController _signInController;

  @override
  void initState() {
    super.initState();
    _signInController = SignInController(widget.sections);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
        viewModel: _signInController,
        child: Builder(
          builder: (context) => GoBack(
            goBackPath: '/select-user',
            changeDefaultBehavior: () => _signInController.defualtBehavior(),
            child: PageView(
              controller: _signInController.controller,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.sections,
            ),
          ),
        ));
  }
}
