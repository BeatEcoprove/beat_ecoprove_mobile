import 'package:beat_ecoprove/clothing/presentation/clothing_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:beat_ecoprove/core/widgets/filter/wrap_filter_options.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_button.dart';
import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
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
  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ClothingViewModel>(context);
    late bool haveSelectedCards = viewModel.haveSelectedCards;

    return Scaffold(
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
  return SliverAppBar(
    toolbarHeight: 76, // TODO: Change
    shadowColor: Colors.transparent,
    backgroundColor: AppColor.widgetBackground,
    pinned: true,
    flexibleSpace: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Expanded(
              child: FormattedTextField(
                hintText: "Pesquisar",
                leftIcon: Icon(Icons.search_rounded),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 6),
            ),
            FilterButton(options: _convertDataToView(viewModel)),
          ],
        ),
      ),
    ),
  );
}

List<WrapFilterOptions> _convertDataToView(ClothingViewModel viewModel) {
  return optionsToFilter.map((item) {
    int index = optionsToFilter.indexOf(item);

    return WrapFilterOptions(
      key: Key(index.toString()),
      title: item.title,
      filterOptions: _convertFilterButtons(item.options, viewModel),
    );
  }).toList();
}

List<IconButtonRectangular> _convertFilterButtons(
    List<FilterButtonItem> options, ClothingViewModel viewModel) {
  return options.map((filter) {
    int index = options.indexOf(filter);

    return IconButtonRectangular(
      key: Key(index.toString()),
      idText: filter.text,
      object: filter.content,
      isCircular: filter.isCircular,
      dimension: filter.dimension,
      isSelected: viewModel.haveThisFilter(filter.text),
      onPress: () => {viewModel.changeFilterSelection(filter.text)},
    );
  }).toList();
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
          CardList(
            selectedOnChange: (card) => {viewModel.changeSelection(card)},
            removeOnAction: (card) => {viewModel.removeCard(card)},
          ),
        ],
      ),
    ),
  );
}
