import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/level_progress.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ProfileViewModel>(context);
    final goRouter = GoRouter.of(context);
    final User user = viewModel.user;

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
                    _header(user, goRouter, context),
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
                    _medals(viewModel, goRouter),
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
    User user,
    GoRouter goRouter,
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
            percent: user.levelPercent,
            level: user.level,
            color: AppColor.primaryColor,
            url: user.avatarUrl,
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
            onPress: () => goRouter.push("/prizes"),
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
            onPress: () => goRouter.push("/changeprofile"),
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
                  points: user.ecoScore,
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
            '${user.xp.toString()}/${user.nextLevelXp.toString()}',
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
                  points: user.ecoScore,
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
                points: user.sustainablePoints,
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
                points: user.ecoCoins,
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  Column _createProfileExtended(
    User user,
    GoRouter goRouter,
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      false,
      user,
      goRouter,
      context,
      width,
      175,
      160,
      175,
    );
  }

  Column _createProfileCompact(
    User user,
    GoRouter goRouter,
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      true,
      user,
      goRouter,
      context,
      width,
      125,
      130,
      130,
    );
  }

  Column _header(User user, GoRouter goRouter, BuildContext context) {
    double width = (MediaQuery.of(context).size.width);

    if (width < AppColor.maxWidthToImageWithMediaQuery) {
      return _createProfileCompact(user, goRouter, context, width);
    } else {
      return _createProfileExtended(user, goRouter, context, width);
    }
  }

  Widget _medals(ProfileViewModel viewModel, GoRouter goRouter) {
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
                onTap: () {
                  goRouter.push(
                    "/list_details",
                    extra: ListDetailsViewParams(
                        title: "Minhas Medalhas",
                        onSearch: (searchTerm) async {
                          return viewModel.medalItems
                              .where((medal) => medal.title
                                  .toLowerCase()
                                  .contains(searchTerm.toLowerCase()))
                              .toList();
                        }),
                  );
                },
              ),
            )
          ],
        ),
        ...viewModel.medalItems,
      ],
    );
  }
}
