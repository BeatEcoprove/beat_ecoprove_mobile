import 'package:beat_ecoprove/client/clothing/domain/data/filters.dart';
import 'package:beat_ecoprove/client/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_button.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClothingView extends IView<ClotingViewModel> {
  const ClothingView({
    super.key,
    required super.viewModel,
  });

  Widget createBucketCard(ClotingViewModel viewModel) {
    return DefaultFormattedTextField(
      hintText: "Nome do cesto",
      onChange: (name) => viewModel.setName(name),
      initialValue: viewModel.getValue(FormFieldValues.name).value,
      errorMessage: viewModel.getValue(FormFieldValues.name).error,
    );
  }

  List<ServiceTemplate> setUpOptions(
    BuildContext context,
    ClotingViewModel viewModel,
  ) {
    return [
      ServiceItem(
        backgroundColor: AppColor.widgetBackground,
        borderColor: Colors.transparent,
        foregroundColor: AppColor.buttonBackground,
        title: "Novo cesto",
        idText: "bucket_new_bucket",
        content: const Icon(
          Icons.add,
          size: 50,
          color: AppColor.buttonBackground,
        ),
        action: () {
          createOverlay(viewModel, context);
        },
      ),
      for (var bucket in viewModel.getBuckets) ...{
        ServiceItem(
          backgroundColor: AppColor.widgetBackground,
          borderColor: Colors.transparent,
          foregroundColor: AppColor.buttonBackground,
          title: bucket.title,
          idText: "bucket",
          content: const SvgImage(
            path: "assets/services/bucket.svg",
            height: 20,
            width: 20,
            color: AppColor.buttonBackground,
          ),
          action: () async => {
            await viewModel.addToBucket(
              bucket.id,
              viewModel.selectedCloth,
            ),
          },
        )
      }
    ];
  }

  void createOverlay(
    ClotingViewModel viewModel,
    BuildContext context,
  ) {
    Modal(
      top: 72,
      bottom: 72,
      left: 36,
      right: 36,
      action: () async =>
          await viewModel.registerBucket(viewModel.selectedCloth),
      titleModal: "Criar Cesto",
      buttonText: "Criar",
    ).create(
      context,
      createBucketCard(
        viewModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context, ClotingViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
        title: "Vestuário",
        sustainablePoints: viewModel.user.sustainablePoints,
      ),
      body: AppBackground(
        type: AppBackgrounds.clothing,
        content: Stack(
          children: [
            CustomScrollView(
              controller: viewModel.scrollController,
              slivers: [
                _buildSearchBarAndFilter(viewModel),
                _buildFilterSelector(viewModel),
                _buildClothsCardsSection(context, viewModel),
              ],
            ),
            if (viewModel.selectedCloth.isNotEmpty) ...[
              const Positioned(
                bottom: 44,
                right: 6,
                child: SvgImage(
                  path: "assets/others/decoration.svg",
                  height: 75,
                  width: 75,
                ),
              ),
              Positioned(
                bottom: 16,
                right: 26,
                child: FloatingButton(
                  color: AppColor.buttonBackground,
                  dimension: 64,
                  icon: const Icon(
                    size: 34,
                    Icons.directions_walk_rounded,
                    color: AppColor.widgetBackground,
                  ),
                  onPressed: () async => await viewModel.setStateFromCloth(),
                ),
              ),
              if (viewModel.haveBucketInSelected) ...{
                Positioned(
                  bottom: 96,
                  right: 26,
                  child: FloatingButton(
                    color: AppColor.bucketButton,
                    dimension: 64,
                    icon: const SvgImage(
                      path: "assets/services/bucket.svg",
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () => viewModel.createBucket(
                      setUpOptions(context, viewModel),
                    ),
                  ),
                ),
              },
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
      ),
    );
  }

  SliverAppBar _buildSearchBarAndFilter(ClotingViewModel viewModel) {
    const Radius borderRadius = Radius.circular(5);

    return SliverAppBar(
      toolbarHeight: 76,
      automaticallyImplyLeading: false,
      shadowColor: Colors.transparent,
      backgroundColor: AppColor.widgetBackground,
      pinned: true,
      snap: true,
      floating: true,
      flexibleSpace: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: DefaultFormattedTextField(
                  hintText: "Pesquisar",
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                  leftIcon: const Icon(Icons.search_rounded),
                  onChange: (search) => viewModel.setSearch(search),
                  initialValue:
                      viewModel.getValue(FormFieldValues.search).value,
                  errorMessage:
                      viewModel.getValue(FormFieldValues.search).error,
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
                options: viewModel.getFilters(),
                onSelectionChanged: (filter) =>
                    viewModel.changeFilterSelection(filter),
                filterIsSelect: (filter) => viewModel.haveThisFilter(filter),
                selectedFilters: viewModel.filterSelection,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildFilterSelector(ClotingViewModel viewModel) {
    return SliverAppBar(
      toolbarHeight: 46,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.widgetBackground,
      flexibleSpace: SizedBox(
        height: 40,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          children: [
            HorizontalSelectorList(
              list: clothes,
              onSelectionChanged: (tags) => {
                viewModel.selectHorizontalTag(tags),
              },
              isHorizontalFilterSelected: (filter) =>
                  viewModel.horizontalSelectedTags.contains(filter),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildClothsCardsSection(
      BuildContext context, ClotingViewModel viewModel) {
    return SliverToBoxAdapter(
      child: viewModel.cloths.isNotEmpty
          ? cardList(viewModel)
          : Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.darkGreen,
                ),
              ),
            ),
    );
  }

  Padding cardList(ClotingViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CardList(
            clothesItems: viewModel.cloths,
            selectedCards: viewModel.selectedCloth,
            onSelectionToDelete: (id) async => await viewModel.removeCloth(id),
            onSelectionChanged: (cards) =>
                viewModel.changeCardsSelection(cards),
            onElementSelected: (card) async =>
                await viewModel.openInfoCard(card),
            action: "remove",
          ),
        ],
      ),
    );
  }
}
