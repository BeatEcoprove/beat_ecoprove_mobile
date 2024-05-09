import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/button_with_icon.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class ServiceProviderProfileView
    extends LinearView<ServiceProviderProfileViewModel> {
  const ServiceProviderProfileView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(
      BuildContext context, ServiceProviderProfileViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
        title: "Perfil",
        sustainablePoints: viewModel.user?.sustainablePoints ?? 0,
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

  Widget _topProfile(double heightProfileImage) {
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
        path: ServerImage(viewModel.user?.avatarUrl ?? ''),
      ),
    ));
  }

  Column _createProfile(
    BuildContext context,
    double width,
    double heightProfileImage,
  ) {
    return Column(
      children: [
        Stack(children: [
          Center(
            child: _topProfile(heightProfileImage),
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
          viewModel.user?.name ?? 'User Name',
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
              points: viewModel.user?.sustainablePoints ?? 0,
            ),
          ],
        ),
      ],
    );
  }

  Column _createProfileExtended(
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      context,
      width,
      175,
    );
  }

  Column _createProfileCompact(
    BuildContext context,
    double width,
  ) {
    return _createProfile(
      context,
      width,
      125,
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
