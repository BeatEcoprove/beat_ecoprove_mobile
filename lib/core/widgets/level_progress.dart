import 'dart:math';

import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class LevelProgress extends StatelessWidget {
  static const double ratioOffset = 50;
  final double height;
  final Color color;
  final VoidCallback? onPress;
  final String path;
  final double percent;
  final int level;

  const LevelProgress({
    required this.height,
    required this.color,
    required this.path,
    this.percent = 0,
    this.level = 0,
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + calculateOffset,
      width: height,
      child: Stack(
        children: [
          Container(
            height: height,
            width: height,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.center,
            child: CustomPaint(
              size: Size(height, height),
              foregroundPainter: LevelProgressPainter(
                completeColor: color,
                width: 7,
                percent: percent,
              ),
              child: ClipOval(
                child: Image.asset(
                  path,
                  width: height,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipOval(
                child: Container(
                  width: ratioOffset,
                  height: ratioOffset,
                  decoration: const BoxDecoration(
                      color: AppColor.widgetBackground,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [AppColor.defaultShadow]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Nível",
                        style: AppText.superSmallSubHeader,
                      ),
                      Text(
                        level.toString(),
                        style: AppText.smallHeader,
                      ),
                      Text(
                        "${percent}%",
                        style: AppText.percentText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get calculateOffset => ratioOffset / 2 - 5;
}

class LevelProgressPainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  Color completeColor;
  double width;
  double percent;

  LevelProgressPainter({
    required this.completeColor,
    required this.width,
    required this.percent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    for (var i = 0; i < 50; i++) {
      double arcAngle = 2 * pi * percent / 100;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
          arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
