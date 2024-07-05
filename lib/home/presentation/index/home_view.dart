import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/advert_item.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/services/datetime_service.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advert_header.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advet_card_root.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_model.dart';
import 'package:beat_ecoprove/home/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeView extends LinearView<HomeViewModel> {
  const HomeView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
          hasSearchBar: true,
          sustainablePoints: viewModel.user?.sustainablePoints ?? 0),
      body: CustomScrollView(
        slivers: [
          _buildWelcomeSection(viewModel.user),
          _buildAdvertisementSection(),
          _buildPopularServicesSection(),
        ],
      ),
    );
  }

  SliverPadding _buildWelcomeSection(User? user) {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            WelcomeCard(
              levelPercent: user?.levelPercent ?? 0,
              userAvatarPictureUrl: user?.avatarUrl.toString() ?? '',
              userLevel: user?.level ?? 0,
              userName: user?.name ?? '',
            ),
            const Padding(
              padding: EdgeInsets.only(top: 29),
            ),
            const Text(
              "Publicidade e Oportunidades",
              style: AppText.titleToScrollSection,
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

  SliverToBoxAdapter _buildPopularServicesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 16, left: 12),
            child: Text(
              "Serviços Populares",
              style: AppText.titleToScrollSection,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (viewModel.servicesProviders.isEmpty) ...[
                  Center(
                      child: Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 64),
                    child: const Text(
                      "Não existem Prestadores de Serviço!",
                      style: AppText.subHeader,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                ] else ...[
                  for (var service in viewModel.servicesProviders)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CompactListItemRoot(
                        click: () => viewModel.goToInfoService(service),
                        items: [
                          ImageTitleSubtitleHeader(
                            widget: PresentImage(
                              path: ServerImage(service.icon),
                            ),
                            title: service.name,
                            subTitle: service.type,
                          ),
                          WithOptionsFooter(
                            options: [
                              OptionItem(
                                name: 'Não voltar a aparecer',
                                action: () {},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
