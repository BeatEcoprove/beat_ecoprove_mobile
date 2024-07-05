import 'package:async/async.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/advert_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/services/datetime_service.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card.dart';
import 'package:beat_ecoprove/core/widgets/advertisement_card/advertisement_card_provider.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advert_header.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advet_card_root.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
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

  List<Widget> _renderCards(List<StoreItem> stores) {
    return stores
        .map(
          (e) => Container(
            margin: const EdgeInsets.only(top: 6, bottom: 6),
            child: CompactListItemRoot(
              items: [
                ImageTitleSubtitleHeader(
                  isCircular: true,
                  widget: PresentImage(
                    path: ServerImage(e.picture),
                  ),
                  title: e.name,
                  subTitle: '',
                ),
                const WithoutOptionsFooter(),
              ],
            ),
          ),
        )
        .toList();
  }

  SliverToBoxAdapter _buildStores() {
    final memo = AsyncMemoizer();

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
          FutureBuilder(
            future: memo.runOnce(
                () async => await viewModel.getStores(args.serviceProviderId)),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  );
                default:
                  return Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 18,
                              right: 18,
                              bottom: 26,
                            ),
                            child: Column(
                              children: [
                                Column(
                                    children: viewModel.stores.isEmpty
                                        ? [
                                            const Center(
                                              child: Text(
                                                "Não existem lojas!",
                                                textAlign: TextAlign.center,
                                                style: AppText.smallSubHeader,
                                              ),
                                            )
                                          ]
                                        : _renderCards(viewModel.stores)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _renderAdverts(List<AdvertItem> adverts) {
    return adverts
        .map(
          (card) => Container(
            margin: const EdgeInsets.only(top: 6, bottom: 6),
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
        )
        .toList();
  }

  SliverToBoxAdapter _buildAdvertisements() {
    final memo = AsyncMemoizer();

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
              FutureBuilder(
                future: memo.runOnce(() async =>
                    await viewModel.getAdverts(args.serviceProviderId)),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      );
                    default:
                      return Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 0,
                                  left: 18,
                                  right: 18,
                                  bottom: 26,
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                        children: viewModel.adverts.isEmpty
                                            ? [
                                                const Center(
                                                  child: Text(
                                                    "Não existem anúncios!",
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        AppText.smallSubHeader,
                                                  ),
                                                )
                                              ]
                                            : _renderAdverts(
                                                viewModel.adverts)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
