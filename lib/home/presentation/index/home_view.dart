import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_text.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/home/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildWelcomeSection(),
        _buildAdvertisementSection(),
        _buildPopularServicesSection(),
      ],
    );
  }

  SliverPadding _buildWelcomeSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            const WelcomeCard(),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var service in services)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CompactListItem(
                    widget: service.widget,
                    title: service.title,
                    subTitle: service.subtitle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
