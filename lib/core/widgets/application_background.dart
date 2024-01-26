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

  Widget background5(Widget content) {
    return Stack(children: [
      const Positioned.fill(
          top: -45,
          right: -45,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgImage(
              path: 'assets/background5/background1.svg',
              height: backgroundImageHeight,
              width: backgroundImageHeight,
            ),
          )),
      const Positioned.fill(
          top: 400,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SvgImage(
              path: 'assets/background1/background2.svg',
              height: backgroundImageHeight,
              width: backgroundImageHeight,
            ),
          )),
      Positioned.fill(
        bottom: 80,
        right: -20,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Transform.rotate(
            angle: 0.5,
            child: const SvgImage(
              path: "assets/background4/background2.svg",
              height: 50,
              width: 50,
            ),
          ),
        ),
      ),
      content
    ]);
  }

  Widget background6(Widget content) {
    return Stack(children: [
      const Positioned.fill(
          bottom: 50,
          left: -85,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SvgImage(
              path: 'assets/background6/background1.svg',
              height: 200,
              width: 200,
            ),
          )),
      content
    ]);
  }

  Widget background7(Widget content) {
    return Stack(children: [
      const Positioned.fill(
          top: -45,
          right: -45,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgImage(
              path: 'assets/background5/background1.svg',
              height: backgroundImageHeight,
              width: backgroundImageHeight,
            ),
          )),
      content
    ]);
  }

  Widget background8(Widget content) {
    return Stack(children: [
      const Positioned.fill(
          left: -45,
          bottom: -50,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SvgImage(
              path: 'assets/background8/background2.svg',
              height: backgroundImageHeight,
              width: backgroundImageHeight,
            ),
          )),
      const Positioned.fill(
          top: -60,
          right: -80,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgImage(
              path: 'assets/background8/background1.svg',
              height: 200,
              width: 200,
            ),
          )),
      content
    ]);
  }

  Widget background9(Widget content) {
    return Stack(children: [
      Positioned.fill(
          bottom: 50,
          left: -40,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Transform.rotate(
              angle: 2.2,
              child: const SvgImage(
                path: 'assets/background1/background1.svg',
                height: backgroundImageHeight,
                width: backgroundImageHeight,
              ),
            ),
          )),
      content
    ]);
  }

  Widget background10(Widget content) {
    return Stack(children: [
      const Positioned.fill(
          right: -25,
          top: 20,
          child: Align(
            alignment: Alignment.topRight,
            child: SvgImage(
              path: 'assets/background1/background1.svg',
              height: backgroundImageHeight,
              width: backgroundImageHeight,
            ),
          )),
      const Positioned.fill(
          bottom: 70,
          left: -100,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SvgImage(
              path: 'assets/background10/background1.svg',
              height: 200,
              width: 200,
            ),
          )),
      content
    ]);
  }

  Widget registerClothBackground(Widget content) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColor.darkestBlue,
        ),
        const Positioned.fill(
          bottom: -95,
          right: -10,
          child: Align(
            alignment: Alignment.bottomRight,
            child: SvgImage(
              path: "assets/register_cloth_background/register_cloth.svg",
              height: 260,
              width: 260,
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
      case AppBackgrounds.closet:
        return background5(content);
      case AppBackgrounds.infoBucket:
        return background6(content);
      case AppBackgrounds.settings:
        return background7(content);
      case AppBackgrounds.trade:
        return background8(content);
      case AppBackgrounds.members:
        return background9(content);
      case AppBackgrounds.createGroup:
        return background10(content);
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
  registerClothBackground1,
  closet,
  infoBucket,
  settings,
  trade,
  members,
  createGroup
}
