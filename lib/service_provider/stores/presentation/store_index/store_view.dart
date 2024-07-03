import 'package:async/async.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_and_text_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/with_text_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoreView extends LinearView<StoreViewModel> {
  const StoreView({
    super.key,
    required super.viewModel,
  });

  Widget _buildSearchBarAndFilter(StoreViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 60,
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
          ],
        ),
      ),
    );
  }

  List<Widget> _renderCards(StoreViewModel viewModel, List<StoreItem> stores) {
    return stores
        .map(
          (e) => Container(
            margin: const EdgeInsets.only(top: 12, bottom: 6),
            child: InkWell(
              onTap: () => viewModel.goToStore(e),
              child: viewModel.hasAuthorization()
                  ? CompactListItemRoot(
                      items: [
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
                        WithOptionsAndTextFooter(
                          options: [
                            OptionItem(
                              name: 'Remover',
                              action: () async => {},
                            ),
                          ],
                          text: "Nível ${e.level}",
                        )
                      ],
                    )
                  : CompactListItemRoot(
                      items: [
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
                      ],
                    ),
            ),
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
  Widget build(BuildContext context, StoreViewModel viewModel) {
    final memo = AsyncMemoizer();

    return Scaffold(
      appBar: StandardHeader(
        title: "Lojas",
        sustainablePoints: viewModel.user?.sustainablePoints ?? 0,
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
                                      children: viewModel.stores.isEmpty
                                          ? [
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 36),
                                                child: const Text(
                                                  "Não existem lojas!",
                                                  textAlign: TextAlign.center,
                                                  style: AppText.smallSubHeader,
                                                ),
                                              )
                                            ]
                                          : _renderCards(
                                              viewModel,
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
