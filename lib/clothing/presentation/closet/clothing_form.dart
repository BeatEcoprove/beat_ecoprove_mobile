import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_button.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class ClothingForm extends StatefulWidget {
  const ClothingForm({
    super.key,
  });

  @override
  State<ClothingForm> createState() => _ClothingFormState();
}

class _ClothingFormState extends State<ClothingForm> {
  late ClothingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModel.of<ClothingViewModel>(context);
    late bool haveSelectedCards = viewModel.haveSelectedCards;

    return Scaffold(
      appBar: StandardHeader(
          title: "Vestuário",
          sustainablePoints: viewModel.user.sustainablePoints),
      body: AppBackground(
        content: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildSearchBarAndFilter(viewModel),
                _buildFilterSelector(viewModel),
                _buildClothsCardsSection(context, viewModel),
              ],
            ),
            if (haveSelectedCards) ...[
              const Positioned(
                bottom: 16,
                right: 26,
                child: FloatingButton(
                  color: AppColor.buttonBackground,
                  dimension: 64,
                  icon: Icon(
                    size: 34,
                    Icons.directions_walk_rounded,
                    color: AppColor.widgetBackground,
                  ),
                ),
              ),
              const Positioned(
                bottom: 44,
                right: 6,
                child: SvgImage(
                  path: "assets/others/decoration.svg",
                  height: 75,
                  width: 75,
                ),
              ),
              const Positioned(
                bottom: 96,
                right: 26,
                child: FloatingButton(
                  color: AppColor.bucketButton,
                  dimension: 64,
                  icon: SvgImage(
                    path: "assets/services/bucket.svg",
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ] else ...[
              const Positioned(
                bottom: 16,
                right: 26,
                child: FloatingButton(
                  color: AppColor.darkGreen,
                  dimension: 64,
                  icon: Icon(
                    size: 34,
                    Icons.notifications_none_rounded,
                    color: AppColor.widgetBackground,
                  ),
                ),
              ),
              const Positioned(
                bottom: 78,
                right: 9,
                child: FloatingButton(
                  color: AppColor.buttonBackground,
                  dimension: 49,
                  icon: Icon(
                    size: 29,
                    Icons.qr_code,
                    color: AppColor.widgetBackground,
                  ),
                ),
              ),
            ],
          ],
        ),
        type: AppBackgrounds.clothing,
      ),
    );
  }
}

SliverAppBar _buildSearchBarAndFilter(ClothingViewModel viewModel) {
  const Radius borderRadius = Radius.circular(5);

  return SliverAppBar(
    toolbarHeight: 76,
    shadowColor: Colors.transparent,
    backgroundColor: AppColor.widgetBackground,
    pinned: false,
    floating: true,
    flexibleSpace: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Expanded(
              child: DefaultFormattedTextField(
                hintText: "Pesquisar",
                leftIcon: Icon(Icons.search_rounded),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 6),
            ),
            FilterButton(
              bodyButton: Container(
                width: 52,
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColor.widgetBackground,
                  borderRadius: BorderRadius.all(borderRadius),
                  boxShadow: [AppColor.defaultShadow],
                ),
                child: const SvgImage(
                  path: "assets/filter/settings.svg",
                  height: 24,
                  width: 24,
                  color: AppColor.widgetSecondary,
                ),
              ),
              overlayPaddingBottom: 86,
              overlayPaddingTop: 110,
              contentPaddingTop: 56,
              bodyTop: 0,
              options: optionsToFilter
                  .map((filter) => filter.toFilterRow())
                  .toList(),
              onSelectionChanged: (filter) =>
                  {viewModel.changeFilterSelection(filter)},
              filterIsSelect: (filter) => viewModel.haveThisFilter(filter),
              selectedFilters: viewModel.allSelectedFilters,
            ),
          ],
        ),
      ),
    ),
  );
}

SliverAppBar _buildFilterSelector(ClothingViewModel viewModel) {
  return SliverAppBar(
    toolbarHeight: 46,
    pinned: true,
    backgroundColor: AppColor.widgetBackground,
    flexibleSpace: SizedBox(
      height: 40,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: [
          HorizontalSelectorList(
            list: clothes,
            onSelectionChanged: (ids) =>
                {viewModel.changeHorizontalFiltersSelection(ids)},
            isHorizontalFilterSelected: (filter) =>
                viewModel.haveThisHorizontalFilter(filter),
          ),
        ],
      ),
    ),
  );
}

SliverToBoxAdapter _buildClothsCardsSection(
    BuildContext context, ClothingViewModel viewModel) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: viewModel.fetchCloset(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator(
                    color: AppColor.primaryColor,
                    strokeWidth: 4,
                  );
                default:
                  return CardList(
                    clothesItems: viewModel.getCloset,
                    onSelectionToDelete: (id) => {viewModel.removeCard(id)},
                    onSelectionChanged: (cards) =>
                        {viewModel.changeCardsSelection(cards)},
                  );
              }
            },
          ),
        ],
      ),
    ),
  );
}
