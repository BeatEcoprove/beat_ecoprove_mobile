import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class SelectorItem extends StatelessWidget {
  static const double heigth = 46;
  static const BoxConstraints selectorContrains = BoxConstraints(maxWidth: 400);
  static const double verticalPadding = 15;
  static const double horizontalPadding = 0;

  final String title;
  final bool selected;

  const SelectorItem({required this.title, this.selected = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: selectorContrains,
      child: Container(
        height: heigth,
        decoration: const BoxDecoration(
          boxShadow: [AppColor.defaultShadow],
          borderRadius: AppColor.borderRadius,
          color: AppColor.widgetBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColor.widgetSecondary,
                fontWeight: FontWeight.bold,
                fontSize: AppText.title5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
