import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class IconButtonRectangular extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final VoidCallback? onPress;
  final Color colorBackground;
  final Widget? object;
  final double dimension;
  final bool isCircular;

  const IconButtonRectangular({
    Key? key,
    this.colorBackground = AppColor.widgetBackground,
    this.object,
    this.onPress,
    this.dimension = 40,
    this.isCircular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          color: colorBackground,
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircular ? null : const BorderRadius.all(borderRadius),
          boxShadow: const [AppColor.defaultShadow],
        ),
        child: Center(child: object),
      ),
    );
  }
}

enum IconButtonRetangularType implements Comparable<IconButtonRetangularType> {
  recycle(
      colorBackground: AppColor.darkGreen,
      object: SvgImage(
        path: 'assets/services/recycle.svg',
        width: 30,
        height: 30,
      )),
  iron(
      colorBackground: AppColor.orange,
      object: SvgImage(
        path: 'assets/services/iron.svg',
        width: 30,
        height: 30,
      )),
  dry(
      colorBackground: AppColor.yellow,
      object: SvgImage(
        path: 'assets/services/dry.svg',
        width: 30,
        height: 30,
      )),
  wash(
      colorBackground: AppColor.lightBlue,
      object: SvgImage(
        path: 'assets/services/wash.svg',
        width: 50,
        height: 50,
      )),
  repair(
      colorBackground: AppColor.darkBlue,
      object: SvgImage(
        path: 'assets/services/repair.svg',
        width: 30,
        height: 30,
      ));

  final Color colorBackground;
  final Widget object;

  const IconButtonRetangularType({
    required this.colorBackground,
    required this.object,
  });

  @override
  int compareTo(IconButtonRetangularType other) {
    throw UnimplementedError();
  }
}
