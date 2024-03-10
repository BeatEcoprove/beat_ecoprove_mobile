import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final String title;
  final double dimension;
  final Icon? icon;
  final Color colorBackground;
  final Color colorSecondary;
  final SvgImage? svg;
  final void Function()? onPress;

  const ButtonWithIcon(
      {required this.title,
      required this.icon,
      this.dimension = 75,
      this.onPress,
      this.colorBackground = AppColor.widgetBackground,
      this.colorSecondary = AppColor.darkGreen,
      Key? key})
      : svg = null,
        super(key: key);

  const ButtonWithIcon.svg(
      {required this.title,
      required this.svg,
      this.dimension = 75,
      this.onPress,
      this.colorBackground = AppColor.widgetBackground,
      this.colorSecondary = AppColor.darkGreen,
      Key? key})
      : icon = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: dimension,
            decoration: BoxDecoration(
              color: colorBackground,
              borderRadius: const BorderRadius.all(borderRadius),
              boxShadow: const [AppColor.defaultShadow],
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: dimension,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppText.smallHeader,
                ),
              ],
            )),
          ),
          Positioned(
            child: Container(
                padding: const EdgeInsets.all(8),
                height: dimension,
                width: dimension,
                decoration: BoxDecoration(
                  color: colorSecondary,
                  borderRadius: BorderRadius.all(borderRadius),
                  boxShadow: [AppColor.defaultShadow],
                ),
                child: icon ?? svg),
          )
        ],
      ),
    );
  }
}
