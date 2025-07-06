import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/brands/see_brands/see_brands_view_model.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/floating_button.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class SeeBrandsView extends LinearView<SeeBrandsViewModel> {
  final double firstSectionHeightPercent = 65;

  const SeeBrandsView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, SeeBrandsViewModel viewModel) {
    return Scaffold(
      appBar: StandardHeader(
        title: LocaleContext.get().core_brands_see_brands_brands,
        hasSustainablePoints: false,
        sustainablePoints: 0,
      ),
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(child: _buildBrands(context, viewModel)),
                _createBrand(viewModel),
              ],
            ),
          ),
        ),
        type: AppBackgrounds.registerClothBackground1,
      ),
    );
  }

  Widget _buildBrands(BuildContext context, SeeBrandsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 76),
      child: Column(
        children: [
          for (var brand in viewModel.brands)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CompactListItemRoot(
                items: [
                  ImageTitleSubtitleHeader(
                    widget: PresentImage(
                      fit: BoxFit.contain,
                      path: ServerImage(brand.brandAvatar),
                    ),
                    title: brand.name,
                    subTitle: "",
                  ),
                  WithOptionsFooter(
                    options: [
                      OptionItem(
                        name: LocaleContext.get().core_brands_see_brands_report,
                        action: () {
                          //TODO: Report
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Positioned _createBrand(SeeBrandsViewModel viewModel) {
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
        onPressed: () => viewModel.goToCreateBrand(),
      ),
    );
  }
}
