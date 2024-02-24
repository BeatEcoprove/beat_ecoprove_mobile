import 'dart:math';

import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class LevelProgress extends StatelessWidget {
  static const double ratioOffset = 50;
  final double height;
  final Color color;
  final VoidCallback? onPress;
  final String url;
  final double percent;
  final int level;

  const LevelProgress({
    required this.height,
    required this.color,
    required this.url,
    this.percent = 0,
    this.level = 0,
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tween<double> tween = Tween<double>(begin: 0, end: percent);
    double imgSize = 300;

    return SizedBox(
      height: height + calculateOffset,
      width: height,
      child: TweenAnimationBuilder(
        tween: tween,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        builder: (context, value, child) => Stack(
          children: [
            Container(
              height: height,
              width: height,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              alignment: Alignment.center,
              child: CustomPaint(
                size: Size(height, height),
                foregroundPainter: LevelProgressPainter(
                  completeColor: AppColor.beatFirefly,
                  width: 7,
                  percent: value,
                ),
                child: ClipOval(
                    child: SizedBox(
                  width: imgSize,
                  height: imgSize,
                  child: PresentImage(
                    path: ServerImage(url),
                  ),
                )),
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
                          "${value.toStringAsFixed(0)}%",
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
