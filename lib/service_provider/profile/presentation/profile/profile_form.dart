import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/button_with_icon.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceProviderProfileForm extends StatelessWidget {
  const ServiceProviderProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ServiceProviderProfileViewModel>(context);
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
                      height: 36,
                    ),
                    // TODO: CHANGE IN THE FUTURE
                    // if (user.type != 'funcionario')
                    _options(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topProfile(User user, double heightProfileImage) {
    // TODO: CHANGE IN THE FUTURE
    // if (user.type == 'gerente') {
    //   return LevelProgress(
    //     height: heightProfileImage,
    //     percent: user.levelPercent,
    //     level: user.level,
    //     color: AppColor.primaryColor,
    //     url: user.avatarUrl,
    //   );
    // }

    return ClipOval(
        child: SizedBox(
      width: heightProfileImage,
      height: heightProfileImage,
      child: PresentImage(
        path: ServerImage(user.avatarUrl),
      ),
    ));
  }

  Column _createProfile(
    User user,
    GoRouter goRouter,
    BuildContext context,
    double width,
    double heightProfileImage,
  ) {
    return Column(
      children: [
        Stack(children: [
          Center(
            child: _topProfile(user, heightProfileImage),
          ),
        ]),
        // TODO: CHANGE IN THE FUTURE
        // if (user.type == 'gerente')
        //   const SizedBox(
        //     height: 6,
        //   ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       '${user.xp.toString()}/${user.nextLevelXp.toString()}',
        //       textAlign: TextAlign.center,
        //       style: AppText.titleToScrollSection,
        //     ),
        //     const SizedBox(
        //       width: 3,
        //     ),
        //     const Text(
        //       'XP',
        //       textAlign: TextAlign.center,
        //       style: AppText.rating,
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 16,
        ),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: AppText.titleToScrollSection,
        ),
        const SizedBox(
          height: 16,
        ),
        //TODO: CHANGE IN THE FUTURE
        // if (user.type != 'funcionario')
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
      ],
    );
  }

  Column _createProfileExtended(
    User user,
    GoRouter goRouter,
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      user,
      goRouter,
      context,
      width,
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
      user,
      goRouter,
      context,
      width,
      125,
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
}

Widget _options() {
  return Wrap(
    runSpacing: 8,
    children: [
      ButtonWithIcon.svg(
        title: "Prémios",
        svg: const SvgImage(
          path: "assets/gift-sharp.svg",
          color: AppColor.widgetBackground,
          height: 36,
          width: 36,
        ),
        //TODO: GO TO PAGE
        onPress: () => {},
      ),
      ButtonWithIcon(
        title: "Anúncios Ativos",
        icon: const Icon(
          Icons.newspaper_sharp,
          color: AppColor.widgetBackground,
          size: 40,
        ),
        //TODO: GO TO PAGE
        onPress: () => {},
      ),
    ],
  );
}
