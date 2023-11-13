import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:flutter/material.dart';

class StepByStep extends StatefulWidget {
  static const Color mainColor = AppColor.darkGreen;
  static const double gap = 27;

  final int numberOfSteps;
  final int currentStep;

  const StepByStep(
      {required this.numberOfSteps, required this.currentStep, Key? key})
      : super(key: key);

  @override
  State<StepByStep> createState() => _StepByStepState();
}

class _StepByStepState extends State<StepByStep> {
  Widget isStepCompleted(int i) {
    bool isCompleted = i < widget.currentStep;

    return Circle(
      isFull: isCompleted,
      height: 48,
      child: isCompleted
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : Text(
              (i + 1).toString(),
              style: const TextStyle(
                fontSize: AppText.title2,
                color: StepByStep.mainColor,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double multiply = (widget.numberOfSteps.toDouble() / 2.0).floorToDouble();
    double lineWidth = 101 - (27 * multiply);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.numberOfSteps; i++) ...[
          isStepCompleted(i),
          if (i < widget.numberOfSteps - 1)
            Line(
              color: StepByStep.mainColor,
              width: lineWidth,
            ),
        ],
      ],
    );
  }
}
