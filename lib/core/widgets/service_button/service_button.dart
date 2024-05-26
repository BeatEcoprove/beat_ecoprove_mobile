import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/service_button/service_button_template.dart';
import 'package:flutter/material.dart';

class ServiceButton extends ServiceButtonTemplate {
  final bool isSelect;
  final bool isBlocked;

  const ServiceButton({
    super.key,
    required super.dimension,
    required super.colorBackground,
    required super.colorBorder,
    required super.colorForeground,
    required super.object,
    required super.title,
    this.isSelect = false,
    this.isBlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.body(),
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
