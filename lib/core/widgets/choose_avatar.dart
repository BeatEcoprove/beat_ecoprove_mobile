import 'dart:math';

import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class ChooseAvatar extends StatelessWidget {
  final double heigth;

  const ChooseAvatar({this.heigth = 185, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(children: [
        CustomPaint(
          size: Size(heigth, heigth),
          foregroundPainter: MyPainter(
              completeColor: AppColor.widgetSecondary,
              width: 5,
              dashWidth: 10,
              dashSpace: 0.1),
          child: SizedBox(
            height: heigth,
            width: heigth,
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        const Positioned(
            bottom: 0,
            right: 0,
            child: CircularButton(
              height: 58,
            )),
      ]),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double height;
  final void Function()? onTap;

  const CircularButton({this.height = 10, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? onTap,
      child: Container(
        height: height,
        width: height,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [AppColor.defaultShadow]),
        child: const Icon(Icons.auto_fix_normal_outlined),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  Color completeColor;
  double width;
  double dashWidth;
  double dashSpace;

  MyPainter({
    required this.completeColor,
    required this.width,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width * 0.001) / 2;

    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 8; i++) {
      var init = (-pi / 2) * (i / 2);

      // Create a path for the dashed arc
      Path dashPath = Path();
      dashPath.addArc(
        Rect.fromCircle(center: center, radius: radius),
        init,
        arcAngle,
      );

      // Draw the dashed arc
      canvas.drawPath(
        dashPath,
        complete
          ..shader =
              null, // To remove any shader that may have been set previously
      );

      // Advance the starting point for the next dash
      init += (arcAngle + dashSpace);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
