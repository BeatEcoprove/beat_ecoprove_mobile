import 'package:beat_ecoprove/clothing/domain/data/filters.dart';
import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/presentation/select_service_view.dart';
import 'package:beat_ecoprove/core/view_model.dart';
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
import 'package:go_router/go_router.dart';

class ClothingForm extends StatefulWidget {
  const ClothingForm({
    super.key,
  });

  @override
  State<ClothingForm> createState() => _ClothingFormState();
}

class _ClothingFormState extends State<ClothingForm> {
  late ClothingViewModel viewModel;
  late Modal _overlay;

  @override
  void initState() {
    super.initState();

    _overlay = Modal(
      top: 198,
      bottom: 198,
      left: 36,
      right: 36,
      action: () async =>
          await viewModel.registerBucket(viewModel.selectedCards),
      titleModal: "Criar Cesto",
      buttonText: "Criar",
    );
  }

  Widget createBucketCard() {
    return DefaultFormattedTextField(
      hintText: "Nome do cesto",
      onChange: (name) => viewModel.setName(name),
      initialValue: viewModel.getValue(FormFieldValues.name).value,
      errorMessage: viewModel.getValue(FormFieldValues.name).error,
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModel.of<ClothingViewModel>(context);
    final GoRouter goRouter = GoRouter.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            if (viewModel.haveSelectedCards) ...[
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
              const Positioned(
                bottom: 44,
                right: 6,
                child: SvgImage(
                  path: "assets/others/decoration.svg",
                  height: 75,
                  width: 75,
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
                    onPressed: () {
                      goRouter.push(
                        "/select_service",
                        extra: ServiceParams(
                          services: {
                            "Em que cesto pretende inserir esta peça?": [
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
                                action: () => _overlay.create(
                                    context, createBucketCard()),
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
                                      viewModel.selectedCards,
                                    ),
                                  },
                                )
                              }
                            ],
                          },
                        ),
                      );
                    },
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
        type: AppBackgrounds.clothing,
      ),
    );
  }

  SliverAppBar _buildSearchBarAndFilter(ClothingViewModel viewModel) {
    const Radius borderRadius = Radius.circular(5);
    final options = viewModel.getFilters;

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
              Expanded(
                child: DefaultFormattedTextField(
                  hintText: "Pesquisar",
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(35),
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
                options: options,
                onSelectionChanged: (filter) =>
                    viewModel.changeFilterSelection(filter),
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
                if (snapshot.connectionState == ConnectionState.waiting &&
                    viewModel.getCloset.isEmpty) {
                  return const CircularProgressIndicator(
                    color: AppColor.primaryColor,
                    strokeWidth: 4,
                  );
                }

                return CardList(
                  clothesItems: snapshot.data as List<CardItem>,
                  selectedCards: viewModel.selectedCards,
                  onSelectionToDelete: (id) async =>
                      await viewModel.removeCard(id),
                  onSelectionChanged: (cards) =>
                      viewModel.changeCardsSelection(cards),
                  onElementSelected: (card) async =>
                      await viewModel.openInfoCard(card),
                  action: "remove",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
