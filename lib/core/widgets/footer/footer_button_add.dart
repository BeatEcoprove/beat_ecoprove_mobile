import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(5);

  const FooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.darkGreen,
          boxShadow: [AppColor.defaultShadow],
          borderRadius: BorderRadius.all(borderRadius)),
      height: 42,
      width: 50,
      child: const Icon(
        size: 24,
        Icons.add,
        color: AppColor.widgetBackground,
      ),
    );
  }
}
