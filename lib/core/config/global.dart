import 'package:flutter/material.dart';

class AppColor {
  // Widget Colors
  static const Color widgetBackgroud = Color(0xFFFFFFFF);
  static const Color widgetSecondary = Color.fromRGBO(106, 119, 138, 100);
  static const Color buttonBackground = Color.fromRGBO(26, 65, 87, 100);

  static const Color primaryColor = Color.fromRGBO(114, 170, 69, 100);
  static const Color darkColor = Color.fromARGB(0, 13, 192, 255);
}

class AppText {
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
