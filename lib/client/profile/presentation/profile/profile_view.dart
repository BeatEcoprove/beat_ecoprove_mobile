import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/level_progress.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileView extends LinearView<ProfileViewModel> {
  const ProfileView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
        title: "Perfil",
        sustainablePoints: viewModel.user.sustainablePoints,
        hasSustainablePoints: false,
        hasSettings: true,
        settingsPress: () => viewModel.settings(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    _header(context),
                    const SizedBox(
                      height: 16,
                    ),
                    const Line(
                      width: 250,
                      color: AppColor.separatedLine,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _medals(viewModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _createProfile(
    bool isEcoScoreInRow,
    BuildContext context,
    double width,
    double heightProfileImage,
    double leftGiftButton,
    double rightProfileButton,
  ) {
    return Column(children: [
      Stack(children: [
        Center(
          child: LevelProgress(
            height: heightProfileImage,
            percent: viewModel.user.levelPercent,
            level: viewModel.user.level,
            color: AppColor.primaryColor,
            url: viewModel.user.avatarUrl,
          ),
        ),
        Positioned(
          top: 6,
          left: (width / 2) - leftGiftButton,
          child: CircularButton.svg(
            height: 46,
            colorBackground: AppColor.primaryColor,
            svg: const SvgImage(
              path: "assets/gift-sharp.svg",
              color: AppColor.widgetBackground,
              height: 24,
              width: 24,
            ),
            onPress: () => viewModel.goPrizes(),
          ),
        ),
        Positioned(
          top: 65,
          right: (width / 2) - rightProfileButton,
          child: CircularButton(
            height: 46,
            colorBackground: AppColor.primaryColor,
            icon: const Icon(
              Icons.person,
              color: AppColor.widgetBackground,
            ),
            onPress: () => viewModel.goChangeProfile(),
          ),
        ),
        if (!isEcoScoreInRow)
          Positioned(
            top: 146,
            right: (width / 2) - 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Eco-Score",
                  textAlign: TextAlign.center,
                  style: AppText.smallSubHeader,
                ),
                const SizedBox(
                  height: 4,
                ),
                Points.ecoScore(
                  points: viewModel.user.ecoScore,
                ),
              ],
            ),
          )
      ]),
      const SizedBox(
        height: 6,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${viewModel.user.xp.toString()}/${viewModel.user.nextLevelXp.toString()}',
            textAlign: TextAlign.center,
            style: AppText.titleToScrollSection,
          ),
          const SizedBox(
            width: 3,
          ),
          const Text(
            'XP',
            textAlign: TextAlign.center,
            style: AppText.rating,
          ),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Text(
        viewModel.user.name,
        textAlign: TextAlign.center,
        style: AppText.titleToScrollSection,
      ),
      const SizedBox(
        height: 26,
      ),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          if (isEcoScoreInRow)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Eco-Score",
                  textAlign: TextAlign.center,
                  style: AppText.smallSubHeader,
                ),
                const SizedBox(
                  height: 4,
                ),
                Points.ecoScore(
                  points: viewModel.user.ecoScore,
                ),
              ],
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Pontos Sustentáveis",
                textAlign: TextAlign.center,
                style: AppText.smallSubHeader,
              ),
              const SizedBox(
                height: 4,
              ),
              Points.sustainablePoints(
                points: viewModel.user.sustainablePoints,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Eco-Coins",
                textAlign: TextAlign.center,
                style: AppText.smallSubHeader,
              ),
              const SizedBox(
                height: 4,
              ),
              Points.ecoCoins(
                points: viewModel.user.ecoCoins,
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  Column _createProfileExtended(
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      false,
      context,
      width,
      175,
      160,
      175,
    );
  }

  Column _createProfileCompact(
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      true,
      context,
      width,
      125,
      130,
      130,
    );
  }

  Column _header(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);

    if (width < AppColor.maxWidthToImageWithMediaQuery) {
      return _createProfileCompact(context, width);
    } else {
      return _createProfileExtended(context, width);
    }
  }

  Widget _medals(ProfileViewModel viewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text(
                  "Medalhas",
                  style: AppText.titleToScrollSection,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                child: const Text(
                  "Ver Mais",
                  textAlign: TextAlign.center,
                  style: AppText.underlineStyle,
                ),
                onTap: () => viewModel.goListDetails(),
              ),
            )
          ],
        ),
        ...viewModel.medalItems,
      ],
    );
  }
}
