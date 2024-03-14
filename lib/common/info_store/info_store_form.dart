import 'package:beat_ecoprove/common/info_store/info_store_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/store_header.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/rating_bar.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_form.dart';
import 'package:flutter/material.dart';

class InfoStoreForm extends StatefulWidget {
  final StoreItem card;

  const InfoStoreForm({
    super.key,
    required this.card,
  });

  @override
  State<InfoStoreForm> createState() => _InfoStoreFormState();
}

class _InfoStoreFormState extends State<InfoStoreForm> {
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
                widget.card.name,
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
                        "${widget.card.locality} (${widget.card.country})",
                        style: AppText.subHeader,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${widget.card.street}, ${widget.card.numberPort}",
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
    return RatingBarWidget(rating: widget.card.rating);
  }

  Widget _reviews(InfoStoreViewModel viewModel) {
    return Column(
      children: [
        Row(
          children: [
            HorizontalSelectorList(
              list: viewModel.getFilters,
              onSelectionChanged: (filter) =>
                  viewModel.changeFilterSelection(filter),
              isHorizontalFilterSelected: (filter) =>
                  viewModel.haveThisFilter(filter),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InfoStoreViewModel>(context);
    const Radius borderRadius = Radius.circular(10);
    double maxWidth = MediaQuery.of(context).size.width;

    var storeParams = StoreParams(
      storeId: widget.card.id,
      name: widget.card.name,
      numberWorkers: widget.card.numberWorkers,
      picture: widget.card.picture,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StoreHeader(
        title: widget.card.name,
        numberMembers: widget.card.numberWorkers,
        picture: widget.card.picture,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _infoStore(viewModel, maxWidth, storeParams),
              _rating(),
              const SizedBox(
                height: 12,
              ),
              Line(
                width: maxWidth / 3,
                color: AppColor.separatedLine,
              ),
              const SizedBox(
                height: 24,
              ),
              _reviews(viewModel),
            ],
          ),
        ),
      ),
    );
  }
}
