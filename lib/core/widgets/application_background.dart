import 'package:beat_ecoprove/core/config/global.dart';
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

  Widget background3(Widget content) {
    return Stack(
      children: [
        const Positioned.fill(
          bottom: -70,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SvgImage(
              path: "assets/others/decoration1.svg",
              height: 200,
              width: 200,
            ),
          ),
        ),
        content,
      ],
    );
  }

  Widget background4(Widget content) {
    return Stack(
      children: [
        const Positioned.fill(
          bottom: -60,
          left: -70,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SvgImage(
              path: "assets/background4/background1.svg",
              height: 200,
              width: 200,
            ),
          ),
        ),
        const Positioned.fill(
          top: 10,
          right: -20,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgImage(
              path: "assets/background4/background2.svg",
              height: 50,
              width: 50,
            ),
          ),
        ),
        content,
      ],
    );
  }

  Widget registerClothBackground(Widget content) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: AppColor.darkestBlue,
                    boxShadow: [AppColor.defaultShadow],
                  ),
                ),
                const Positioned.fill(
                  bottom: -70,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SvgImage(
                      path:
                          "assets/register_cloth_background/register_cloth.svg",
                      height: 260,
                      width: 260,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        content,
      ],
    );
  }

  Widget defaultBackground(Widget content) {
    switch (type) {
      case AppBackgrounds.login:
        return background1(content);
      case AppBackgrounds.completed:
        return background2(content);
      case AppBackgrounds.clothing:
        return background3(content);
      case AppBackgrounds.registerClothBackground:
        return registerClothBackground(content);
      case AppBackgrounds.registerClothBackground1:
        return background4(content);
      default:
        return background1(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: defaultBackground(content));
  }
}

enum AppBackgrounds {
  login,
  completed,
  clothing,
  registerClothBackground,
  registerClothBackground1
}
