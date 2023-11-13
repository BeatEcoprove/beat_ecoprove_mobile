import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:flutter/material.dart';

class PlaceToPlace extends StatelessWidget {
  final String origin;
  final String destination;

  const PlaceToPlace({
    super.key,
    required this.origin,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Circle(
                strokeWidth: 5,
                color: AppColor.bottomNavigationBar,
                height: 28,
              ),
              const SizedBox(
                width: 2,
              ),
              Line(
                color: AppColor.widgetSecondary,
                dashSpacing: 10,
                width: maxWidth - 140,
              ),
              const SizedBox(
                width: 2,
              ),
              const Circle(
                strokeWidth: 5,
                color: AppColor.bottomNavigationBar,
                height: 28,
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: maxWidth / 2 - 40,
                child: Text(
                  origin,
                  style: AppText.superSmallSubHeader,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: maxWidth / 2 - 40,
                child: Text(
                  textAlign: TextAlign.end,
                  destination,
                  style: AppText.superSmallSubHeader,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
