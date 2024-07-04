import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_provider.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_text.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view_model.dart';
import 'package:flutter/material.dart';

class ServiceView
    extends ArgumentView<ServiceViewModel, ServiceProviderParams> {
  const ServiceView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ServiceViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
          hasSearchBar: false,
          sustainablePoints: viewModel.user?.sustainablePoints ?? 0),
      body: GoBack(
        posLeft: 22,
        posTop: 22,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              _buildServiceCard(),
              _buildStores(),
              _buildAdvertisements(),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildServiceCard() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 84),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            AdvertisementCard(
              widget: PresentImage(path: ServerImage(args.picture)),
              cardContext: AdvertisementCardProviderContext(
                title: args.name,
                subTitle: args.type,
                icon: IconButtonRectangular(
                  dimension: 50,
                  object: PresentImage(path: ServerImage(args.picture)),
                ),
                services: const [IconButtonRetangularType.wash],
                rating:
                    viewModel.getValue(FormFieldValues.code).value?.rating ?? 0,
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
                padding: const EdgeInsets.only(bottom: 36),
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
