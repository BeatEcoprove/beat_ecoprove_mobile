import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double height;
  final Icon? icon;
  final Color colorBackground;
  final SvgImage? svg;
  final void Function()? onPress;

  const CircularButton(
      {required this.icon,
      this.height = 10,
      this.onPress,
      this.colorBackground = Colors.white,
      Key? key})
      : svg = null,
        super(key: key);

  const CircularButton.svg(
      {required this.svg,
      this.height = 10,
      this.onPress,
      this.colorBackground = Colors.white,
      Key? key})
      : icon = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorBackground,
            boxShadow: const [AppColor.defaultShadow]),
        child: icon ?? svg,
      ),
    );
  }
}
