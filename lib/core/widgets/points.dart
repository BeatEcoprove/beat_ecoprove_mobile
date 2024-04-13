import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class Points extends StatefulWidget {
  final int points;
  final SvgImage image;

  const Points.sustainablePoints({
    super.key,
    required this.points,
    this.image = const SvgImage(
      width: 24,
      height: 24,
      path: "assets/points/sustainable_points_icon.svg",
    ),
  });

  const Points.ecoCoins({
    super.key,
    required this.points,
    this.image = const SvgImage(
      width: 22,
      height: 22,
      path: "assets/points/eco_coins_points_icon.svg",
    ),
  });

  const Points.ecoScore({
    super.key,
    required this.points,
    this.image = const SvgImage(
      width: 24,
      height: 24,
      path: "assets/points/eco_score_points_icon.svg",
    ),
  });

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {
  static const Radius borderRadius = Radius.circular(5);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 30,
        decoration: const BoxDecoration(
            color: AppColor.widgetBackground,
            boxShadow: [AppColor.defaultShadow],
            borderRadius: BorderRadius.all(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.points.toString(),
                  style: AppText.smallHeader,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 6), child: widget.image)
          ],
        ));
  }
}
