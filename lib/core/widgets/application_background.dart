import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  static const double backgroundImageHeight = 150;

  final Widget content;
  final AppBackgrounds type;

  const AppBackground({required this.content, required this.type, Key? key})
      : super(key: key);

  Widget background1(Widget content) {
    return Stack(children: [
      const Positioned.fill(
          child: Align(
        alignment: Alignment.topRight,
        child: SvgImage(
          path: 'assets/background1/background1.svg',
          height: backgroundImageHeight,
          width: backgroundImageHeight,
        ),
      )),
      // Second Widget
      const Positioned.fill(
          top: 130,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SvgImage(
              path: 'assets/background1/background2.svg',
              height: backgroundImageHeight,
              width: backgroundImageHeight,
            ),
          )),
      // Second Widget
      const Positioned.fill(
          child: Align(
        alignment: Alignment.bottomRight,
        child: SvgImage(
          path: 'assets/background1/background3.svg',
          height: backgroundImageHeight,
          width: backgroundImageHeight,
        ),
      )),
      content
    ]);
  }

  Widget background2(Widget content) {
    return Stack(children: [
      const Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: SvgImage(
            path: 'assets/background2/background1.svg',
            height: 200,
            width: 200,
          ),
        ),
      ),
      // Second Widget
      const Positioned.fill(
        top: 130,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: SvgImage(
            path: 'assets/background2/background2.svg',
            height: backgroundImageHeight,
            width: backgroundImageHeight,
          ),
        ),
      ),
      content
    ]);
  }

  Widget defualtBackground(Widget content) {
    switch (type) {
      case AppBackgrounds.login:
        return background1(content);
      case AppBackgrounds.completed:
        return background2(content);
      default:
        return background1(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: defualtBackground(content));
  }
}

enum AppBackgrounds { login, completed }
