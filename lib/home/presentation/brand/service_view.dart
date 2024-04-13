import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_provider.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_text.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view_model.dart';
import 'package:flutter/material.dart';

class ServiceView extends LinearView<ServiceViewModel> {
  const ServiceView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, ServiceViewModel viewModel) {
    return CustomScrollView(
      slivers: [
        _buildServiceCard(),
        _buildStores(),
        _buildAdvertisements(),
      ],
    );
  }

  SliverPadding _buildServiceCard() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 24),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            AdvertisementCard(
              widget: serviceView.widget,
              cardContext: AdvertisementCardProviderContext(
                title: serviceView.title,
                subTitle: serviceView.subtitle,
                icon: serviceView.icon,
                services: serviceView.services,
                rating: serviceView.rating,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildStores() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
            child: Text(
              "Lojas",
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
                for (var store in stores)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CompactListItemRoot(
                      items: [
                        ImageTitleSubtitleHeader(
                          isCircular: true,
                          widget: store.image,
                          title: store.name,
                          subTitle: store.serviceProvider,
                        ),
                        const WithoutOptionsFooter(),
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

SliverToBoxAdapter _buildAdvertisements() {
  return SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
          child: Text(
            "Publicidade e Oportunidades",
            style: AppText.titleToScrollSection,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var card in cards)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AdvertisementCard(
                  widget: card.widget,
                  cardContext: AdvertisementCardTextContext(
                    title: card.title,
                    subTitle: card.subtitle,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
