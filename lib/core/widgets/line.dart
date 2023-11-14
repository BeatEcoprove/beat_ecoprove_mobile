import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final double width;
  final double stroke;
  final Color color;
  final double dashSpacing;
  final double dashLength;

  const Line({
    super.key,
    required this.width,
    this.stroke = 2,
    required this.color,
    this.dashSpacing = 0,
    this.dashLength = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, stroke),
      painter: LinePainter(
        stroke: stroke,
        color: color,
        dashSpacing: dashSpacing,
        dashLength: dashLength,
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double stroke;
  final Color color;
  final double dashSpacing;
  final double dashLength;

  LinePainter({
    required this.stroke,
    required this.color,
    this.dashSpacing = 0,
    this.dashLength = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = stroke;

    for (double startX = 0;
        startX < size.width;
        startX += dashLength + dashSpacing) {
      final endX = (startX + dashLength) < size.width
          ? (startX + dashLength)
          : size.width;
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(endX, size.height / 2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
