import 'package:beat_ecoprove/core/widgets/step_by_step/step_by_step.dart';
import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  final double strokeWidth;
  final Color? color;
  final double height;
  final Widget? child;
  final bool isFull;

  const Circle(
      {required this.height,
      this.child,
      this.strokeWidth = 2,
      this.color,
      this.isFull = false,
      Key? key})
      : super(key: key);

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = ColorTween(
            begin: Colors.transparent,
            end: widget.color ?? StepByStep.mainColor)
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFull) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _animation.value,
            border: Border.all(
                color: widget.color ?? StepByStep.mainColor,
                width: widget.strokeWidth)),
        height: widget.height,
        width: widget.height,
        child: Center(child: widget.child),
      ),
    );
  }
}
