import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double height;
  final Icon icon;
  final void Function()? onPress;

  const CircularButton(
      {required this.icon, this.height = 10, this.onPress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: height,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [AppColor.defaultShadow]),
        child: icon,
      ),
    );
  }
}
