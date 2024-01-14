import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_provider.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_text.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  Widget build(BuildContext context) {
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
                    child: CompactListItem.withoutOptions(
                      isCircular: true,
                      widget: store.image,
                      title: store.name,
                      subTitle: store.serviceProvider,
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
