import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplicationBackground extends StatelessWidget {
  final Widget content;

  const ApplicationBackground({required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Positioned.fill(
        child: FittedBox(
          alignment: Alignment.topRight,
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            'assets/background1.svg',
            width: 150, // Use the screen width
            height: 150, // Use the screen height
          ),
        ),
      ),
      // Second Widget
      Positioned.fill(
        top: 130,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            'assets/background2.svg',
            width: 150, // Use the screen width
            height: 150, // Use the screen height
          ),
        ),
      ),
      // Second Widget
      Positioned.fill(
        child: FittedBox(
          alignment: Alignment.bottomRight,
          fit: BoxFit.scaleDown,
          child: SvgPicture.asset(
            'assets/background3.svg',
            width: 150, // Use the screen width
            height: 150, // Use the screen height
          ),
        ),
      ),
      content
    ]));
  }
}
