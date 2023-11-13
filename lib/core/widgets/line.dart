import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final double width;
  final double stroke;
  final Color color;
  final double dashSpacing;
  final double dashLength;

  const Line({
    super.key,
    this.width = 10,
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

    final path = Path();
    for (double startX = 0;
        startX < size.width;
        startX += dashLength + dashSpacing) {
      final endX = startX + dashLength;
      path.moveTo(startX, size.height / 2);
      path.lineTo(endX, size.height / 2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
