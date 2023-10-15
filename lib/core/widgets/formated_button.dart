import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FormattedButton extends StatelessWidget {
  static const double defaultHeight = 46;
  static const double defaultWidth = 247;
  static const Radius defaultRadius = Radius.circular(10);

  final String content;
  final double height;

  const FormattedButton(
      {required this.content, this.height = defaultHeight, Key? key})
      : super(key: key);

  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: height,
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: defaultWidth),
          decoration: const BoxDecoration(
              boxShadow: [AppColor.defaultShadow],
              borderRadius: BorderRadius.all(defaultRadius),
              color: AppColor.buttonBackground),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  content,
                  style: const TextStyle(
                      fontSize: AppText.title2, color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
