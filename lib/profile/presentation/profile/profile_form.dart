import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/level_progress.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/profile/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ProfileViewModel>(context);
    double maxWidth = (MediaQuery.of(context).size.width / 0.75);
    double width = (MediaQuery.of(context).size.width);
    final user = viewModel.user;

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
                    Stack(children: [
                      Center(
                        child: LevelProgress(
                          height: 175,
                          percent: user.levelPercent,
                          level: user.level,
                          color: AppColor.primaryColor,
                          url: user.avatarUrl,
                        ),
                      ),
                      Positioned(
                        top: 6,
                        left: (width / 2) - 160,
                        child: CircularButton.svg(
                          height: 46,
                          colorBackground: AppColor.primaryColor,
                          svg: const SvgImage(
                            path: "assets/gift-sharp.svg",
                            color: AppColor.widgetBackground,
                            height: 24,
                            width: 24,
                          ),
                          onPress: () {},
                        ),
                      ),
                      Positioned(
                        top: 65,
                        right: (width / 2) - 175,
                        child: CircularButton(
                          height: 46,
                          colorBackground: AppColor.primaryColor,
                          icon: const Icon(
                            Icons.person,
                            color: AppColor.widgetBackground,
                          ),
                          onPress: () {},
                        ),
                      ),
                      Positioned(
                        top: 146,
                        right: (width / 2) - 200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Eco-Score",
                              textAlign: TextAlign.center,
                              style: AppText.smallSubHeader,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Points.ecoScore(
                              //TODO: CHANGE TO ecoScore
                              points: 100,
                            ),
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO: Change user XP and max. XP for level
                        Text(
                          user.level.toString() + '/' + '100',
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
                      user.name,
                      textAlign: TextAlign.center,
                      style: AppText.titleToScrollSection,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                              points: user.sustainablePoints,
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   width: 12,
                        // ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Eco-Coins",
                        //       textAlign: TextAlign.center,
                        //       style: AppText.smallSubHeader,
                        //     ),
                        //     SizedBox(
                        //       height: 4,
                        //     ),
                        //     Points.ecoCoins(
                        //       points: 50,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    // Line(width: maxWidth, color: AppColor.separatedLine),
                    // const SizedBox(
                    //   height: 26,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
