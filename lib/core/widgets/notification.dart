import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);
  static const double sizeIcons = 36;

  final String message;
  final Icon icon;
  final Color backgroundColor;
  final Color primaryColor;

  const NotificationWidget({
    super.key,
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.primaryColor,
  });

  const NotificationWidget.error({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.close_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.error,
    this.primaryColor = AppColor.primaryError,
  });

  const NotificationWidget.warning({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.warning_amber_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.warning,
    this.primaryColor = AppColor.primaryWarning,
  });

  const NotificationWidget.info({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.info_outline_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.info,
    this.primaryColor = AppColor.primaryInfo,
  });

  const NotificationWidget.success({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.check_circle_outline_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.primaryColor,
    this.primaryColor = AppColor.darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 88;

    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(borderRadius),
            boxShadow: const [AppColor.defaultShadow],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [AppColor.defaultShadow],
                ),
                child: SvgImage(
                  color: primaryColor,
                  path: 'assets/background5/background1.svg',
                  height: height,
                  width: height,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
                height: height,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                    bottomLeft: borderRadius,
                    topLeft: borderRadius,
                  ),
                  boxShadow: const [AppColor.defaultShadow],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          child: Container(
            margin: const EdgeInsets.only(
              top: height / 3,
              bottom: height / 2,
              left: 80,
              right: 10,
            ),
            child: Text(
              message,
              style: AppText.textButton,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}
