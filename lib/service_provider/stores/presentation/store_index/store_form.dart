import 'package:async/async.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_and_text_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/with_text_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_button.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class StoreForm extends StatelessWidget {
  const StoreForm({
    super.key,
  });

  Widget _buildSearchBarAndFilter(StoreViewModel viewModel) {
    const Radius borderRadius = Radius.circular(5);
    final options = viewModel.getFilters;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 50,
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
                initialValue: viewModel.getValue(FormFieldValues.search).value,
                errorMessage: viewModel.getValue(FormFieldValues.search).error,
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
    );
  }

  List<Widget> _renderCards(
      StoreViewModel viewModel, GoRouter goRouter, List<StoreItem> stores) {
    return stores
        .map(
          (e) => Container(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
            ),
            child: InkWell(
                onTap: () => goRouter.push("/info/store/${e.id}", extra: e),
                child:
                    //TODO: CHANGE BECAUSE OF TYPES OF USERS
                    //     viewModel.user.type == "gerente" :
                    //     CompactListItemRoot(
                    //   items: [
                    //     ImageTitleSubtitleHeader(
                    //       isCircular: true,
                    //       widget: ClipRRect(
                    //         borderRadius: BorderRadius.circular(100),
                    //         child: Image(
                    //           image: ServerImage(e.picture),
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //       title: e.name,
                    //       subTitle: "${e.numberWorkers} funcionários",
                    //     ),
                    //     WithOptionsAndTextFooter(
                    //         options: [], text: "Nível ${e.level}",)
                    //   ],
                    // ),
                    //  ?
                    CompactListItemRoot(items: [
                  ImageTitleSubtitleHeader(
                    isCircular: true,
                    widget: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: ServerImage(e.picture),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: e.name,
                    subTitle: "${e.numberWorkers} funcionários",
                  ),
                  WithTextFooter(text: "Nível ${e.level}")
                ])),
          ),
        )
        .toList();
  }

  Positioned _createStoreButton(StoreViewModel viewModel) {
    return Positioned(
      bottom: 16,
      right: 26,
      child: FloatingButton(
        color: AppColor.darkGreen,
        dimension: 64,
        icon: const Icon(
          size: 34,
          Icons.add_circle_outline_rounded,
          color: AppColor.widgetBackground,
        ),
        onPressed: () async => await viewModel.createStore(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<StoreViewModel>(context);
    final goRouter = GoRouter.of(context);
    final memo = AsyncMemoizer();

    return Scaffold(
      appBar: StandardHeader(
        title: "Lojas",
        sustainablePoints: viewModel.user.sustainablePoints,
        hasSettings: false,
      ),
      body: AppBackground(
        content: Stack(
          children: [
            _buildSearchBarAndFilter(viewModel),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FutureBuilder(
                future: memo.runOnce(() async => await viewModel.getStores()),
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
                        margin: const EdgeInsets.only(top: 74),
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
                                      children: _renderCards(
                                        viewModel,
                                        goRouter,
                                        viewModel.stores,
                                      ),
                                    ),
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
            ),
            _createStoreButton(viewModel),
          ],
        ),
        type: AppBackgrounds.members,
      ),
    );
  }
}
