import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/advert_item.dart';
import 'package:beat_ecoprove/core/services/datetime_service.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advert_header.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advet_card_root.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/service_button/service_button.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/client/profile/presentation/prizes/prizes_view_model.dart';
import 'package:flutter/material.dart';

class PrizesView extends LinearView<PrizesViewModel> {
  const PrizesView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, PrizesViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
        title: 'Prémios',
        hasSustainablePoints: true,
        sustainablePoints: viewModel.user?.sustainablePoints ?? 0,
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: AppBackground(
            content: GoBack(
              posTop: 18,
              posLeft: 18,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 84,
                    ),
                    _changePoints(context),
                    const SizedBox(
                      height: 18,
                    ),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         "Categorias",
                    //         style: AppText.titleToScrollSection,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //     Text(
                    //       "Ver mais",
                    //       style: AppText.underlineStyle,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ],
                    // ),
                    // _categoriesCards(),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Recomendados para si",
                            style: AppText.titleToScrollSection,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 234,
                      child: CustomScrollView(
                        slivers: [
                          _buildAdvertisementSection(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            type: AppBackgrounds.settings,
          ),
        ),
      ),
    );
  }

  Widget _changePoints(BuildContext context) {
    const Radius borderRadius = Radius.circular(10);

    return InkWell(
      onTap: () => viewModel.goTradePoints(),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 75,
        decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: BorderRadius.all(borderRadius),
          boxShadow: [AppColor.defaultShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Trocar Pontos',
                    style: AppText.headerBlack,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Clique aqui para trocar pontos',
                    style: AppText.subHeader,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 75,
              decoration: const BoxDecoration(
                color: AppColor.widgetBackground,
                borderRadius: BorderRadius.all(borderRadius),
                boxShadow: [AppColor.defaultShadow],
              ),
              child: const Row(
                children: [
                  SvgImage(
                    width: 22,
                    height: 22,
                    path: "assets/points/eco_coins_points_icon.svg",
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    Icons.compare_arrows_rounded,
                    color: AppColor.widgetSecondary,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  SvgImage(
                    width: 24,
                    height: 24,
                    path: "assets/points/sustainable_points_icon.svg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriesCards() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            ServiceButton(
              colorForeground: AppColor.buttonBackground,
              colorBorder: AppColor.widgetBackground,
              dimension: 120,
              colorBackground: AppColor.widgetBackground,
              object: SvgImage(
                path: 'assets/services/dry.svg',
                width: 60,
                height: 60,
                color: AppColor.buttonBackground,
              ),
              title: 'Secar',
            ),
            SizedBox(
              width: 6,
            ),
            ServiceButton(
              colorForeground: AppColor.buttonBackground,
              colorBorder: AppColor.widgetBackground,
              dimension: 120,
              colorBackground: AppColor.widgetBackground,
              object: SvgImage(
                path: 'assets/services/wash.svg',
                width: 70,
                height: 70,
                color: AppColor.buttonBackground,
              ),
              title: 'Lavar',
            ),
            SizedBox(
              width: 6,
            ),
            ServiceButton(
              colorForeground: AppColor.buttonBackground,
              colorBorder: AppColor.widgetBackground,
              dimension: 120,
              colorBackground: AppColor.widgetBackground,
              object: SvgImage(
                path: 'assets/services/iron.svg',
                width: 60,
                height: 60,
                color: AppColor.buttonBackground,
              ),
              title: 'Engomar',
            ),
            SizedBox(
              width: 6,
            ),
            ServiceButton(
              colorForeground: AppColor.buttonBackground,
              colorBorder: AppColor.widgetBackground,
              dimension: 120,
              colorBackground: AppColor.widgetBackground,
              object: SvgImage(
                path: 'assets/services/repair.svg',
                width: 60,
                height: 60,
                color: AppColor.buttonBackground,
              ),
              title: 'Reparar',
            ),
            SizedBox(
              width: 6,
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAdvertisementSection() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 231,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.adverts.length,
            itemBuilder: (BuildContext context, int index) {
              var card = viewModel.adverts[index];
              return _buildAdvertisementCard(card);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAdvertisementCard(AdvertItem card) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: SizedBox(
        width: 378,
        child: AdvertCardRoot(
          items: [
            AdvertHeader(
              isCircular: true,
              widget: PresentImage(
                path: ServerImage(card.advertPicture),
              ),
              title: card.title,
              subTitle:
                  '${DatetimeService.formatDateCompact(card.beginIn)} - ${DatetimeService.formatDateCompact(card.endIn)}',
              contentText: card.contentText,
              contentSubText: card.contentSubText,
              options: const [],
            ),
          ],
        ),
      ),
    );
  }
}
