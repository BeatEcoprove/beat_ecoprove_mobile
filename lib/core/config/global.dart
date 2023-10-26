import 'package:flutter/material.dart';

class AppColor {
  static const maxWidthToImage = 313;

  // Widget Colors
  static const Color widgetBackground = Color(0xFFFFFFFF);
  static const Color widgetBackgroundBlurry =
      Color.fromARGB(128, 255, 255, 255);
  static const Color widgetSecondary = Color.fromRGBO(106, 119, 138, 1);
  static const Color buttonBackground = Color.fromRGBO(26, 65, 87, 1);

  static const Color bucketButton = Color.fromRGBO(100, 145, 187, 1);

  static const Color primaryColor = Color.fromRGBO(114, 170, 69, 1);
  static const Color darkGreen = Color.fromRGBO(30, 134, 36, 1);
  static const Color lightGreen = Color.fromRGBO(77, 168, 5, 1);
  static const Color levelProgressGreen = Color.fromRGBO(199, 225, 178, 1);

  static const Color helpGreen = Color.fromRGBO(31, 173, 79, 1);

  static const Color darkGrey = Color.fromRGBO(65, 67, 71, 1);
  static const Color disabledColor = Color.fromRGBO(94, 116, 77, 1);

  static const Color shadowColor = Color.fromRGBO(66, 71, 76, 0.07);

  static const Color bottomNavigationBar = Color.fromRGBO(26, 65, 87, 1);
  static const Color bottomNavigationBarSelected =
      Color.fromRGBO(77, 144, 142, 1);

  static const Color black = Color.fromRGBO(0, 0, 0, 1);

  static const Color orange = Color.fromRGBO(230, 110, 0, 1);
  static const Color yellow = Color.fromRGBO(225, 176, 2, 1);
  static const Color lightBlue = Color.fromRGBO(2, 172, 225, 1);
  static const Color darkBlue = Color.fromRGBO(3, 101, 247, 1);

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(5));

  static const BoxShadow defaultShadow = BoxShadow(
    color: shadowColor,
    blurRadius: 10,
    spreadRadius: 0.0,
  );
}

class AppText {
  static const TextStyle firstHeader = TextStyle(
      color: AppColor.black, fontSize: title2, fontWeight: FontWeight.bold);

  static const TextStyle firstHeaderWhite = TextStyle(
      color: AppColor.widgetBackground,
      fontSize: title2,
      fontWeight: FontWeight.bold);

  static const TextStyle header = TextStyle(
      color: AppColor.buttonBackground,
      fontSize: title2,
      fontWeight: FontWeight.bold);

  static const TextStyle alternativeHeader = TextStyle(
      color: AppColor.darkGrey, fontSize: title2, fontWeight: FontWeight.bold);

  static const TextStyle headerBlack = TextStyle(
      color: AppColor.black, fontSize: title2, fontWeight: FontWeight.bold);

  static const TextStyle titleToScrollSection = TextStyle(
      color: AppColor.buttonBackground,
      fontSize: title3,
      fontWeight: FontWeight.bold);

  static const TextStyle smallHeader = TextStyle(
      color: AppColor.black, fontSize: title4, fontWeight: FontWeight.bold);

  static const TextStyle rating = TextStyle(
      color: AppColor.primaryColor,
      fontSize: title3,
      fontWeight: FontWeight.bold);

  static const TextStyle subHeader = TextStyle(
      color: AppColor.widgetSecondary,
      fontSize: title5,
      fontWeight: FontWeight.bold);

  static const TextStyle smallSubHeader = TextStyle(
      color: AppColor.widgetSecondary,
      fontSize: title6,
      fontWeight: FontWeight.bold);

  static const TextStyle underlineStyle = TextStyle(
      color: AppColor.primaryColor,
      fontSize: AppText.title5,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  static const TextStyle strongStyle = TextStyle(
      color: AppColor.buttonBackground,
      fontSize: AppText.title5,
      fontWeight: FontWeight.bold);

  static const TextStyle superSmallSubHeader = TextStyle(
      color: AppColor.widgetSecondary,
      fontSize: title7,
      fontWeight: FontWeight.bold);

  static const TextStyle percentText = TextStyle(
    color: AppColor.darkGreen,
    fontSize: title8,
    fontWeight: FontWeight.bold,
  );

  // Widget Colors
  static const double title1 = 32;
  static const double title2 = 24;
  static const double title3 = 20;
  static const double title4 = 16;
  static const double title5 = 14;
  static const double title6 = 12;
  static const double title7 = 10;
  static const double title8 = 8;
}
