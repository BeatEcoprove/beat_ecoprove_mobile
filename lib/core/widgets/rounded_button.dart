import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(20);

  final VoidCallback onAction;
  final String text;
  final Widget object;
  final double height;
  final double width;
  final double widthRightPart;

  const RoundedButton({
    super.key,
    required this.onAction,
    this.text = "Utilizar",
    this.object = const Icon(
      Icons.directions_walk_rounded,
      color: AppColor.widgetBackground,
    ),
    this.height = 42,
    this.width = 80,
    this.widthRightPart = 50,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: AppColor.buttonBackground,
              borderRadius: BorderRadius.only(
                  topLeft: borderRadius, bottomLeft: borderRadius),
              boxShadow: [AppColor.defaultShadow],
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: AppText.textButton,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: widthRightPart,
            height: height,
            decoration: const BoxDecoration(
              color: AppColor.bucketButton,
              borderRadius: BorderRadius.only(
                  topRight: borderRadius, bottomRight: borderRadius),
              boxShadow: [AppColor.defaultShadow],
            ),
            child: object,
          ),
        ],
      ),
    );
  }
}
