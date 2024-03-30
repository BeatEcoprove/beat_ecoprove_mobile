import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_text.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_model.dart';
import 'package:beat_ecoprove/home/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeView extends IView<HomeViewModel> {
  const HomeView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
          hasSearchBar: true,
          sustainablePoints: viewModel.user.sustainablePoints),
      body: CustomScrollView(
        slivers: [
          _buildWelcomeSection(viewModel.user),
          _buildAdvertisementSection(),
          _buildPopularServicesSection(),
        ],
      ),
    );
  }

  SliverPadding _buildWelcomeSection(User user) {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            WelcomeCard(
              levelPercent: user.levelPercent,
              userAvatarPictureUrl: user.avatarUrl.toString(),
              userLevel: user.level,
              userName: user.name,
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
      child: SizedBox(
        height: 231,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = cards[index];
            return _buildAdvertisementCard(card);
          },
        ),
      ),
    );
  }

  Widget _buildAdvertisementCard(card) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: SizedBox(
        width: 378,
        child: AdvertisementCard(
          widget: card.widget,
          cardContext: AdvertisementCardTextContext(
            title: card.title,
            subTitle: card.subtitle,
          ),
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
                for (var service in services)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CompactListItemRoot(
                      items: [
                        ImageTitleSubtitleHeader(
                          widget: service.widget,
                          title: service.title,
                          subTitle: service.subtitle,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
