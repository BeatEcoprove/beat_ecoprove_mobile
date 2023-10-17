import 'package:flutter/material.dart';

class AppColor {
  // Widget Colors
  static const Color widgetBackgroud = Color(0xFFFFFFFF);
  static const Color widgetSecondary = Color.fromRGBO(106, 119, 138, 1);
  static const Color buttonBackground = Color.fromRGBO(26, 65, 87, 1);

  static const Color primaryColor = Color.fromRGBO(114, 170, 69, 1);
  static const Color darkGreen = Color.fromRGBO(30, 134, 36, 1);
  static const Color lightGreen = Color.fromRGBO(77, 168, 5, 1);

  static const Color darkGrey = Color.fromRGBO(65, 67, 71, 1);
  static const Color disabledColor = Color.fromRGBO(94, 116, 77, 1);

  static const Color shadowColor = Color.fromRGBO(66, 71, 76, 0.15);

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(5));

  static const BoxShadow defaultShadow = BoxShadow(
    color: shadowColor,
    blurRadius: 40,
    spreadRadius: 0.0,
  );
}

class AppText {
  static const TextStyle header = TextStyle(
      color: AppColor.buttonBackground,
      fontSize: title2,
      fontWeight: FontWeight.bold);

  static const TextStyle alternativeHeader = TextStyle(
      color: AppColor.darkGrey, fontSize: title2, fontWeight: FontWeight.bold);

  // Widget Colors
  static const double title1 = 32;
  static const double title2 = 24;
  static const double title3 = 20;
  static const double title4 = 16;
  static const double title5 = 14;
  static const double title6 = 12;
  static const double title7 = 10;
  static const double title8 = 8;

  static const TextStyle underlineStyle = TextStyle(
      color: AppColor.primaryColor,
      fontSize: AppText.title5,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  static const TextStyle strongStyle = TextStyle(
      color: AppColor.buttonBackground,
      fontSize: AppText.title5,
      fontWeight: FontWeight.bold);
}
