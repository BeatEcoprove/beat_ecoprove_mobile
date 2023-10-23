import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/level_progress.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatefulWidget {
  const WelcomeCard({
    super.key,
  });

  @override
  State<WelcomeCard> createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  CrossAxisAlignment alignment = CrossAxisAlignment.start;
  MainAxisAlignment mainAlignment = MainAxisAlignment.spaceBetween;
  double height = 231;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= AppColor.maxWidthToImage) {
      alignment = CrossAxisAlignment.center;
      mainAlignment = MainAxisAlignment.center;
      height = 160;
    } else {
      alignment = CrossAxisAlignment.start;
      mainAlignment = MainAxisAlignment.spaceBetween;
      height = 231;
    }

    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [AppColor.defaultShadow]),
      child: Row(
        mainAxisAlignment: mainAlignment,
        children: [
          Column(
            crossAxisAlignment: alignment,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: alignment,
                    children: [
                      const Text(
                        "Olá!",
                        style: AppText.firstHeaderWhite,
                      ),
                      Text(
                        user.name,
                        style: AppText.strongStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  IconButtonRectangular(
                    object: Icon(
                      Icons.auto_awesome_mosaic_rounded,
                      color: AppColor.darkGreen,
                    ),
                  ),
                  IconButtonRectangular(
                    object: Icon(
                      Icons.public_rounded,
                      color: AppColor.darkGreen,
                    ),
                  ),
                  IconButtonRectangular(
                    object: Icon(
                      Icons.wallet_giftcard_rounded,
                      color: AppColor.darkGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (MediaQuery.of(context).size.width > AppColor.maxWidthToImage)
            LevelProgress(
                height: 175,
                percent: user.percent,
                level: user.level,
                color: AppColor.levelProgressGreen,
                path: user.path),
        ],
      ),
    );
  }
}
