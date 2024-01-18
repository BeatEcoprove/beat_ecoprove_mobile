import 'package:flutter/material.dart';

class AppColor {
  static const maxWidthToImage = 313;
  static const maxWidthToImageWithMediaQuery = 359;
  static const maxWidthToImageWithMediaQueryCards = 353;

  // Widget Colors
  static const Color widgetBackground = Color(0xFFFFFFFF);
  static const Color widgetBackgroundBlurry =
      Color.fromARGB(128, 255, 255, 255);

  static const Color midGreen = Color.fromARGB(110, 2, 97, 83);

  static const Color widgetBackgroundWithNothing =
      Color.fromRGBO(249, 249, 249, 1);
  static const Color widgetSecondary = Color.fromRGBO(106, 119, 138, 1);
  static const Color separatedLine = Color.fromRGBO(235, 237, 240, 1);
  static const Color buttonBackground = Color.fromRGBO(26, 65, 87, 1);
  static const Color darkestBlue = Color.fromRGBO(9, 0, 46, 1);

  static const Color bucketButton = Color.fromRGBO(100, 145, 187, 1);

  static const Color primaryColor = Color.fromRGBO(114, 170, 69, 1);
  static const Color darkGreen = Color.fromRGBO(30, 134, 36, 1);
  static const Color lightGreen = Color.fromRGBO(77, 168, 5, 1);
  static const Color levelProgressGreen = Color.fromRGBO(199, 225, 178, 1);

  static const Color helpGreen = Color.fromRGBO(31, 173, 79, 1);

  static const Color servicesCloth = Color.fromRGBO(249, 249, 249, 1);
  static const Color darkGrey = Color.fromRGBO(65, 67, 71, 1);
  static const Color disabledColor = Color.fromRGBO(94, 116, 77, 1);

  static const Color shadowColor = Color.fromRGBO(66, 71, 76, 0.08);

  static const Color bottomNavigationBar = Color.fromRGBO(26, 65, 87, 1);
  static const Color bottomNavigationBarSelected =
      Color.fromRGBO(77, 144, 142, 1);

  static const Color endSession = Color.fromRGBO(208, 0, 0, 1);

  static const Color primaryError = Color.fromRGBO(255, 97, 102, 1);
  static const Color error = Color.fromRGBO(255, 58, 65, 1);

  static const Color primaryWarning = Color.fromRGBO(245, 164, 74, 1);
  static const Color warning = Color.fromRGBO(242, 143, 30, 1);

  static const Color primaryInfo = Color.fromRGBO(0, 161, 223, 1);
  static const Color info = Color.fromRGBO(0, 113, 255, 1);

  static const Color black = Color.fromRGBO(0, 0, 0, 1);

  static const Color orange = Color.fromRGBO(230, 110, 0, 1);
  static const Color yellow = Color.fromRGBO(225, 176, 2, 1);
  static const Color lightBlue = Color.fromRGBO(2, 172, 225, 1);
  static const Color darkBlue = Color.fromRGBO(3, 101, 247, 1);

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(5));
  static const BorderRadius borderRadius10 =
      BorderRadius.all(Radius.circular(10));

  static const BoxShadow defaultShadow = BoxShadow(
    color: shadowColor,
    blurRadius: 10,
    spreadRadius: 0.0,
  );
}

class AppText {
  static const TextStyle firstHeader = TextStyle(
    color: AppColor.black,
    fontSize: title2,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle firstHeaderWhite = TextStyle(
    color: AppColor.widgetBackground,
    fontSize: title2,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle header = TextStyle(
    color: AppColor.buttonBackground,
    fontSize: title2,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle alternativeHeader = TextStyle(
    color: AppColor.darkGrey,
    fontSize: title2,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle headerBlack = TextStyle(
    color: AppColor.black,
    fontSize: title2,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle titleToScrollSection = TextStyle(
      color: AppColor.buttonBackground,
      fontSize: title3,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  static const TextStyle rating = TextStyle(
    color: AppColor.primaryColor,
    fontSize: title3,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle smallHeader = TextStyle(
      color: AppColor.black,
      fontSize: title4,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  static const TextStyle textButton = TextStyle(
    color: AppColor.widgetBackground,
    fontSize: title5,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle subHeader = TextStyle(
    color: AppColor.widgetSecondary,
    fontSize: title5,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle smallSubHeader = TextStyle(
    color: AppColor.widgetSecondary,
    fontSize: title6,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle underlineStyle = TextStyle(
      color: AppColor.primaryColor,
      fontSize: AppText.title5,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  static TextStyle strongCustomStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: AppText.title5,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
    );
  }

  static const TextStyle strongStyle = TextStyle(
    color: AppColor.buttonBackground,
    fontSize: AppText.title5,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle superSmallSubHeader = TextStyle(
    color: AppColor.widgetSecondary,
    fontSize: title7,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static const TextStyle percentText = TextStyle(
    color: AppColor.darkGreen,
    fontSize: title8,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
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
