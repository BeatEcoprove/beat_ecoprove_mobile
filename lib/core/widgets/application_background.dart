import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class ApplicationBackground extends StatelessWidget {
  static const double backgroundImageHeigth = 150;

  final Widget content;

  const ApplicationBackground({required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      const Positioned.fill(
          child: Align(
        alignment: Alignment.topRight,
        child: SvgImage(
          path: 'assets/background1.svg',
          heigth: backgroundImageHeigth,
          width: backgroundImageHeigth,
        ),
      )),
      // Second Widget
      const Positioned.fill(
          top: 130,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SvgImage(
              path: 'assets/background2.svg',
              heigth: backgroundImageHeigth,
              width: backgroundImageHeigth,
            ),
          )),
      // Second Widget
      const Positioned.fill(
          child: Align(
        alignment: Alignment.bottomRight,
        child: SvgImage(
          path: 'assets/background3.svg',
          heigth: backgroundImageHeigth,
          width: backgroundImageHeigth,
        ),
      )),
      content
    ]));
  }
}
