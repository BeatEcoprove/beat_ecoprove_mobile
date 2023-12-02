import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class InfoClothServiceView extends StatelessWidget {
  const InfoClothServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoBack(
        posTop: 18,
        posLeft: 18,
        child: Center(child: IconButtonRectangular()),
      ),
    );
  }
}
