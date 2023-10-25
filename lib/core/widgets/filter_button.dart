import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(5);

  final VoidCallback? onPress;
  final Icon icon;

  const FilterButton({
    super.key,
    this.onPress,
    this.icon = const Icon(
      Icons.filter_alt,
      color: AppColor.widgetSecondary,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 52,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: BorderRadius.all(borderRadius),
          boxShadow: [AppColor.defaultShadow],
        ),
        child: icon,
      ),
    );
  }
}
