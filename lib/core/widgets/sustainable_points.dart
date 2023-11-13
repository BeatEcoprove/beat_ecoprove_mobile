import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class SustainablePoints extends StatefulWidget {
  final int sustainablePoints;

  const SustainablePoints({
    super.key,
    required this.sustainablePoints,
  });

  @override
  State<SustainablePoints> createState() => _SustainablePointsState();
}

class _SustainablePointsState extends State<SustainablePoints> {
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
                  widget.sustainablePoints.toString(),
                  style: AppText.smallHeader,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 6),
              child: SvgImage(
                width: 24,
                height: 24,
                path: "assets/points/sustainable_points_icon.svg",
              ),
            )
          ],
        ));
  }
}
