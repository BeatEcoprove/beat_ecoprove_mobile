import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final double dimension;
  final Widget icon;

  const FloatingButton({
    super.key,
    this.onPressed,
    required this.color,
    required this.dimension,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [AppColor.defaultShadow],
      ),
      height: dimension,
      width: dimension,
      child: GestureDetector(
        onTap: onPressed,
        child: icon,
      ),
    );
  }
}
