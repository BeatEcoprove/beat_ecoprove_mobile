import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/service_button/service_button_template.dart';
import 'package:flutter/material.dart';

class PayablePrizeButton extends ServiceButtonTemplate {
  final int prize;

  const PayablePrizeButton({
    super.key,
    required super.dimension,
    required super.colorBackground,
    required super.colorBorder,
    required super.colorForeground,
    required super.object,
    required super.title,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        super.body(),
        const SizedBox(
          height: 6,
        ),
        Points.sustainablePoints(points: prize),
      ],
    );
  }
}
