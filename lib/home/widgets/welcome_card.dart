import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/level_progress.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatefulWidget {
  final String userName;
  final double levelPercent;
  final int userLevel;
  final String userAvatarPictureUrl;

  const WelcomeCard({
    super.key,
    required this.userName,
    required this.levelPercent,
    required this.userLevel,
    required this.userAvatarPictureUrl,
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
    double maxWidth = MediaQuery.of(context).size.width;
    if (maxWidth < AppColor.maxWidthToImageWithMediaQuery) {
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
                        widget.userName,
                        style: AppText.strongStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (maxWidth > AppColor.maxWidthToImageWithMediaQuery)
            LevelProgress(
                height: 175,
                percent: widget.levelPercent,
                level: widget.userLevel,
                color: AppColor.levelProgressGreen,
                url: widget.userAvatarPictureUrl),
        ],
      ),
    );
  }
}
