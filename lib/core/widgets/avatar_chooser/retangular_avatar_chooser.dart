import 'package:beat_ecoprove/core/widgets/avatar_chooser/avatar_chooser.dart';
import 'package:flutter/material.dart';

class RetangularAvatarChooser extends AvatarChooser {
  final ImageProvider imageProvider;

  RetangularAvatarChooser({
    required super.height,
    required super.width,
    required super.color,
    required this.imageProvider,
    Key? key,
    super.onPress,
  }) : super(
          key: key,
          borderShape: BoxShape.rectangle,
          image: ClipOval(
            child: Image(
              image: imageProvider,
              width: height,
              height: width,
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
    Paint paint = Paint()
      ..color = completeColor
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 5;
    double startX = 0;
    final path = Path();

    // Top edge
    while (startX < size.width) {
      path.moveTo(startX, 0);
      startX += dashWidth;
      path.lineTo(startX, 0);
      startX += dashSpace;
    }

    // Right edge
    startX = 0;
    double startY = 0;
    while (startY < size.height) {
      path.moveTo(size.width, startY);
      startY += dashWidth;
      path.lineTo(size.width, startY);
      startY += dashSpace;
    }

    // Bottom edge
    startY = size.height;
    startX = 0;
    while (startX < size.width) {
      path.moveTo(startX, size.height);
      startX += dashWidth;
      path.lineTo(startX, size.height);
      startX += dashSpace;
    }

    // Left edge
    startY = 0;
    while (startY < size.height) {
      path.moveTo(0, startY);
      startY += dashWidth;
      path.lineTo(0, startY);
      startY += dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
