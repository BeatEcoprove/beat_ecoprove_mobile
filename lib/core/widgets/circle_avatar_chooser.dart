import 'dart:math';

import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class CircleAvatarChooser extends StatelessWidget {
  final double height;
  final Color color;
  final VoidCallback? onPress;
  final ImageProvider imageProvider;

  const CircleAvatarChooser({
    required this.height,
    required this.color,
    required this.imageProvider,
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            size: Size(height, height),
            foregroundPainter: MyPainter(completeColor: color, width: 2),
            child: ClipOval(
              child: Image(
                image: imageProvider,
                width: height,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: 5,
              right: 5,
              child: CircularButton(
                onPress: onPress,
                height: 46,
                icon: const Icon(
                  Icons.mode_edit_outline_outlined,
                  color: AppColor.widgetSecondary,
                  size: 26,
                ),
              )),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  Color completeColor;
  double width;

  MyPainter({required this.completeColor, required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width * 0.001) / 2 * 0.1;

    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 50; i++) {
      var init = (-pi / 5) * (i / 5);

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), init,
          arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
