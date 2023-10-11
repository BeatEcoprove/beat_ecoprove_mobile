import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FormatedButton extends StatelessWidget {
  static const double defaultHeight = 46;
  static const double defaultWidth = 247;
  static const Radius defaultRadius = Radius.circular(10);

  final String content;
  final double height;

  const FormatedButton(
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
              borderRadius: BorderRadius.all(defaultRadius),
              color: AppColor.buttonBackground),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Entrar",
                  style:
                      TextStyle(fontSize: AppText.title2, color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
