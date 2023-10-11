import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FormatedTextField extends StatelessWidget {
  final String hintText;
  final Icon leftIcon;

  const FormatedTextField(
      {this.hintText = 'Default Value', required this.leftIcon, Key? key})
      : super(key: key);

  // constantes
  static const double edgeSize = 7;
  static const double horizontalPadding = 18;
  static const double verticalPadding = 0;

  static const Color iconColor = Color.fromARGB(0, 13, 192, 255);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: const BoxDecoration(
            color: AppColor.widgetBackgroud,
            borderRadius: BorderRadius.all(Radius.circular(edgeSize))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                  cursorColor: AppColor.primaryColor,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                        fontSize: AppText.title5,
                        color: AppColor.widgetSecondary,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  )),
            ),
            leftIcon
          ],
        ));
  }
}
