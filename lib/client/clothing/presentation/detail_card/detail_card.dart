import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:flutter/material.dart';

class DetailSwiper extends StatelessWidget {
  final List<LinearView> views;

  const DetailSwiper({
    super.key,
    required this.views,
  });

  List<Line> getLines(double maxWidth) {
    return [
      for (var i = 0; i <= views.length - 1; i++)
        Line(
          width: maxWidth,
          color: AppColor.primaryColor,
          stroke: 3,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = (MediaQuery.of(context).size.width / 2) - 50;

    return Swiper(
      views: views,
      bottomNavigationBarOptions: getLines(maxWidth),
      hasRegisterCloth: false,
    );
  }
}
