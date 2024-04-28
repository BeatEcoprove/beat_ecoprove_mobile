import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/compact_list_item_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends CompactListItemHeader {
  final int userLevel;
  final int sustainablePoints;
  final int ecoScorePoints;
  final bool hasBorder;

  final HeightCard height;

  const ProfileHeader({
    super.key,
    required super.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.hasBorder = false,
    this.height = HeightCard.height88,
  });

  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(10);
    double width = (MediaQuery.of(context).size.width);

    return Row(
      children: [
        Container(
          width: 70,
          height: height.value,
          decoration: BoxDecoration(
            color: hasBorder ? AppColor.primaryInfo : AppColor.darkGreen,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
              bottomLeft: borderRadius,
              topLeft: borderRadius,
            ),
            boxShadow: const [AppColor.defaultShadow],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Nível",
                style: AppText.textButton,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                userLevel.toString(),
                style: AppText.firstHeaderWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: AppText.headerBlack,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Points.sustainablePoints(
                  points: sustainablePoints,
                ),
                if (width > AppColor.maxWidthToImage)
                  Points.ecoScore(points: ecoScorePoints),
              ],
            )
          ],
        )
      ],
    );
  }
}
