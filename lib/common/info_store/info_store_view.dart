import 'package:beat_ecoprove/common/info_store/info_store_params.dart';
import 'package:beat_ecoprove/common/info_store/info_store_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/store_header.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list_store.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/rating_bar.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:flutter/material.dart';

import '../../core/argument_view.dart';

class InfoStoreView extends ArgumentView<InfoStoreViewModel, InfoStoreParams> {
  const InfoStoreView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  Widget _infoStore(
      InfoStoreViewModel viewModel, double maxWidth, StoreParams storeParams) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: (2 / 3) * maxWidth,
              child: Text(
                args.card.name,
                style: AppText.header,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Line(
              width: (2 / 3) * maxWidth,
              color: AppColor.darkGreen,
              dashSpacing: 2,
              dashLength: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (2 / 3) * maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${args.card.locality} (${args.card.country})",
                        style: AppText.subHeader,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${args.card.street}, ${args.card.numberPort}",
                        style: AppText.subHeader,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButtonRectangular(
                  dimension: 50,
                  object: const Icon(
                    Icons.place_outlined,
                    color: AppColor.bottomNavigationBar,
                  ),
                  //TODO: CREATE A WAY TO OPEN GOOGLE MAPS
                  onPress: () => {},
                )
              ],
            )
          ],
        ),
        if (viewModel.hasAuthorization())
          Positioned(
            top: 0,
            right: 2,
            child: CircularButton(
              height: 46,
              icon: const Icon(
                Icons.people_alt_rounded,
                color: AppColor.bottomNavigationBar,
              ),
              onPress: () => viewModel.goToWorkersPage(storeParams),
            ),
          ),
      ],
    );
  }

  Widget _rating() {
    return RatingBarWidget(rating: args.card.rating);
  }

  Widget _reviews(InfoStoreViewModel viewModel) {
    return viewModel.reviews.isNotEmpty
        ? Wrap(
            runSpacing: 6,
            spacing: 6,
            children: viewModel.reviews,
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 36),
            child: const Text(
              "Não existe nenhuma review!",
              style: AppText.subHeader,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          );
  }

  @override
  Widget build(BuildContext context, InfoStoreViewModel viewModel) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height - 96 + 40;

    var storeParams = StoreParams(
      storeId: args.card.id,
      name: args.card.name,
      numberWorkers: args.card.numberWorkers,
      picture: args.card.picture,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StoreHeader(
        title: args.card.name,
        numberMembers: args.card.numberWorkers,
        picture: args.card.picture,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: maxHeight * (1 / 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _infoStore(viewModel, maxWidth, storeParams),
                    _rating(),
                    const SizedBox(
                      height: 6,
                    ),
                    Line(
                      width: maxWidth / 3,
                      color: AppColor.separatedLine,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HorizontalSelectorListStore(
                          list: viewModel.filters,
                          onSelectionChanged: (filter) => viewModel
                              .changeFilterSelection(filter, args.card.id),
                          isHorizontalFilterSelected: (filter) =>
                              viewModel.selectedFilter.contains(filter),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: maxHeight * (2.55 / 4),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _reviews(viewModel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
