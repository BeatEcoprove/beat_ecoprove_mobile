import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final double heigth;
  final double width;

  final String path;

  const SvgImage(
      {required this.path, this.heigth = 0, this.width = 0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SvgPicture.asset(
        path,
        width: width, // Use the screen width
        height: heigth, // Use the screen height
      ),
    );
  }
}
