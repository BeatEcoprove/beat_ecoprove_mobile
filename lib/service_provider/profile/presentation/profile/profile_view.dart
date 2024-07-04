import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/payable_prize.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/button_with_icon.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/level_progress.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 26,
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    _header(context),
                    const SizedBox(
                      height: 36,
                    ),
                    if (viewModel.hasAuthorization()) _options(viewModel),
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
    if (viewModel.isManager()) {
      return LevelProgress(
        height: heightProfileImage,
        percent: viewModel.user!.levelPercent,
        level: viewModel.user!.level,
        color: AppColor.primaryColor,
        url: viewModel.user!.avatarUrl,
      );
    }

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
        if (viewModel.isManager()) ...[
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${viewModel.user!.xp.toString()}/${viewModel.user!.nextLevelXp.toString()}',
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
        ],
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
        if (viewModel.hasAuthorization())
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

List<ServiceTemplate> setUpOptions(ServiceProviderProfileViewModel viewModel) {
  List<ServiceTemplate> possibleOptions = [];
  List<PayablePrizeItem> options = [
    PayablePrizeItem(
      title: "Anúncio",
      idText: "advertisement",
      content: const Icon(Icons.shopping_cart_outlined,
          color: AppColor.buttonBackground, size: 50),
      backgroundColor: AppColor.widgetBackground,
      borderColor: Colors.transparent,
      foregroundColor: AppColor.buttonBackground,
      prize: 150,
      action: () async => await {
        viewModel.goToCreatePrize("advertisement", 150),
      },
    ),
    PayablePrizeItem(
      title: "Promoção",
      idText: "promotion",
      content: const Icon(Icons.discount_rounded,
          color: AppColor.buttonBackground, size: 50),
      backgroundColor: AppColor.widgetBackground,
      borderColor: Colors.transparent,
      foregroundColor: AppColor.buttonBackground,
      prize: 100,
      action: () async => await {
        viewModel.goToCreatePrize("promotion", 100),
      },
    ),
    //local_activity
    PayablePrizeItem(
      title: "Voucher",
      idText: "voucher",
      content: const Icon(Icons.confirmation_num_rounded,
          color: AppColor.buttonBackground, size: 50),
      backgroundColor: AppColor.widgetBackground,
      borderColor: Colors.transparent,
      foregroundColor: AppColor.buttonBackground,
      prize: 10,
      action: () async => await {
        viewModel.goToCreatePrize("voucher", 10),
      },
    ),
  ];

  for (var option in options) {
    if (viewModel.user!.sustainablePoints >= option.prize) {
      possibleOptions.add(option);
    }
  }
  return possibleOptions;
}

Widget _options(ServiceProviderProfileViewModel viewModel) {
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
        onPress: () => {viewModel.createPrize(setUpOptions(viewModel))},
      ),
      ButtonWithIcon(
        title: "Anúncios Ativos",
        icon: const Icon(
          Icons.newspaper_sharp,
          color: AppColor.widgetBackground,
          size: 40,
        ),
        onPress: () => {viewModel.advertsPage()},
      ),
    ],
  );
}
