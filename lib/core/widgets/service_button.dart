import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  final double dimension;
  final Color colorBackground;
  final Color colorBorder;
  final Color colorForeground;
  final Widget object;
  final String title;
  final bool isSelect;
  final bool isBlocked;

  const ServiceButton({
    super.key,
    required this.dimension,
    required this.colorBackground,
    required this.colorBorder,
    required this.colorForeground,
    required this.object,
    required this.title,
    this.isSelect = false,
    this.isBlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(5);

    return Stack(
      children: [
        Container(
          width: dimension,
          height: dimension,
          decoration: BoxDecoration(
            color: colorBackground,
            border: Border.all(
              color: colorBorder,
              strokeAlign: BorderSide.strokeAlignInside,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(borderRadius),
            boxShadow: const [AppColor.defaultShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: dimension - 50,
                  alignment: Alignment.center,
                  child: object,
                ),
                Text(
                  title,
                  style: AppText.strongCustomStyle(colorForeground),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        if (isBlocked)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.widgetBackgroundBlurry,
                borderRadius: AppColor.borderRadius,
              ),
              child: Icon(
                size: dimension - 50,
                Icons.lock_rounded,
                color: AppColor.buttonBackground,
              ),
            ),
          ),
        if (isSelect)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.widgetBackgroundBlurry,
                borderRadius: AppColor.borderRadius,
              ),
              child: Icon(
                size: dimension - 50,
                Icons.check_circle_outline_rounded,
                color: AppColor.buttonBackground,
              ),
            ),
          ),
      ],
    );
  }
}
