import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImage extends StatelessWidget {
  final double height;
  final double width;

  final String path;

  const SvgImage(
      {required this.path, this.height = 0, this.width = 0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SvgPicture.asset(
        path,
        width: width,
        height: height,
      ),
    );
  }
}
