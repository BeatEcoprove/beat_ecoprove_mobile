import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class StepByStep extends StatefulWidget {
  const StepByStep({super.key});

  @override
  State<StepByStep> createState() => _StepByStepState();
}

class _StepByStepState extends State<StepByStep> {
  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Circle(
        height: 48,
      )
    ]);
  }
}

class Circle extends StatelessWidget {
  static const Color _mainColor = AppColor.darkGreen;
  static const double _strokeWidth = 2;
  final double height;

  const Circle({required this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _mainColor, width: _strokeWidth)),
      height: height,
      width: height,
      child: const Center(
        child: Text(
          "1",
          style: TextStyle(
            fontSize: AppText.title2,
            color: _mainColor,
          ),
        ),
      ),
    );
  }
}
