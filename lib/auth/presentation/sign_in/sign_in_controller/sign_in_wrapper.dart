import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_view_controller.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/step_by_step.dart';
import 'package:flutter/material.dart';

class SignInWrapper extends StatelessWidget {
  final List<Stage> sections;

  const SignInWrapper({required this.sections, Key? key}) : super(key: key);

  void _handleGoPrevious(SignInController signInController) {
    var stage = sections[signInController.currentPage];
    var data = stage.viewModel.fields;

    stage.handlePrevious(
      data: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final signInController = ViewModel.of<SignInController>(context);

    return GoBack(
      posTop: 48,
      posLeft: 22,
      changeDefaultBehavior: () => signInController.defualtBehavior(
        () => _handleGoPrevious(signInController),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: SignInViewController.signViewHeaderGap,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: StepByStep(
                  numberOfSteps: sections.length,
                  currentStep: signInController.currentPage,
                ),
              ),
            ),
          ),
          Flexible(
            child: PageView.builder(
              controller: signInController.controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var totalHeight = MediaQuery.of(context).size.height -
                    SignInViewController.signViewHeaderGap;

                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: totalHeight),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 38, right: 38, bottom: 50),
                      child: sections[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
