import 'dart:math';

import 'package:beat_ecoprove/core/widgets/avatar_chooser/avatar_chooser.dart';
import 'package:flutter/material.dart';

class CircleAvatarChooser extends AvatarChooser {
  final ImageProvider imageProvider;

  CircleAvatarChooser({
    required super.height,
    required super.color,
    required this.imageProvider,
    Key? key,
    super.onPress,
  }) : super(
          key: key,
          width: height,
          borderShape: BoxShape.circle,
          image: ClipOval(
            child: Image(
              image: imageProvider,
              width: height,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          foregroundPainter: MyPainter(completeColor: color, width: 2),
        );
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
