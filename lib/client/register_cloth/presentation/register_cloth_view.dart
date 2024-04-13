import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/value_objects/cloth_size.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/value_objects/cloth_type.dart';
import 'package:beat_ecoprove/client/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterClothView extends LinearView<RegisterClothViewModel> {
  final double firstSectionHeightPercent = 65;

  const RegisterClothView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, RegisterClothViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
          title: LocaleContext.get().client_register_register_cloth,
          sustainablePoints: viewModel.user.sustainablePoints,
          hasSustainablePoints: false),
      body: Column(
        children: [
          SizedBox(
            height: calculateHeightSections(firstSectionHeightPercent, context),
            child: AppBackground(
              content: GoBack(
                posTop: 18,
                posLeft: 18,
                child: _buildRegisterForm(context, viewModel),
              ),
              type: AppBackgrounds.registerClothBackground1,
            ),
          ),
          SizedBox(
            height: calculateHeightSections(
                100 - firstSectionHeightPercent, context),
            child: AppBackground(
              content: _buildRegisterClothByQRCode(context),
              type: AppBackgrounds.registerClothBackground,
            ),
          ),
        ],
      ),
    );
  }

  double calculateHeightSections(double percent, BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    // 96 is the height of the header
    return (maxHeight - 96) * (percent / 100);
  }

  Widget _buildRegisterForm(
      BuildContext context, RegisterClothViewModel viewModel) {
    const double textBoxGap = 12;
    const double dimension = 50;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleContext.get().client_register_imagem,
                  style: AppText.subHeader,
                ),
                const SizedBox(
                  width: 12,
                ),
                CircleAvatarChooser(
                  height: 140,
                  color: AppColor.widgetSecondary,
                  imageProvider: viewModel.getClothImage(),
                  onPress: () => viewModel.getImageFromGallery(),
                ),
              ],
            ),
            const SizedBox(
              height: textBoxGap,
            ),
            DefaultFormattedTextField(
              hintText: LocaleContext.get().client_register_name,
              inputFormatter: [
                LengthLimitingTextInputFormatter(18),
              ],
              onChange: (clothName) async => viewModel.setClothName(clothName),
              initialValue: viewModel.getValue(FormFieldValues.clothName).value,
              errorMessage: viewModel.getValue(FormFieldValues.clothName).error,
            ),
            const SizedBox(
              height: textBoxGap,
            ),
            FormattedDropDown(
              options:
                  ClothType.getAllTypes().map((e) => e.displayValue).toList(),
              value: viewModel
                  .getValue(FormFieldValues.clothType)
                  .value
                  .toString(),
              onValueChanged: (value) =>
                  viewModel.setValue(FormFieldValues.clothType, value),
            ),
            const SizedBox(
              height: textBoxGap,
            ),
            FormattedDropDown(
              options: ClothSize.getAllTypes(),
              value: viewModel.getValue(FormFieldValues.clothSize).value,
              onValueChanged: (value) =>
                  viewModel.setValue(FormFieldValues.clothSize, value),
            ),
            const SizedBox(
              height: textBoxGap,
            ),
            if (viewModel.getAllBrands().isNotEmpty)
              FormattedDropDown(
                options: viewModel.getAllBrands(),
                value: viewModel.getValue(FormFieldValues.clothBrand).value,
                onValueChanged: (value) =>
                    viewModel.setValue(FormFieldValues.clothBrand, value),
              ),
            const SizedBox(
              height: textBoxGap,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleContext.get().client_register_color,
                  style: AppText.subHeader,
                ),
                const SizedBox(
                  width: 12,
                ),
                FilterButton(
                  headerButton: const Icon(
                    Icons.close_rounded,
                    size: 36,
                    color: AppColor.widgetSecondary,
                  ),
                  bodyTop: 36,
                  bodyRight: 36,
                  bodyButton: Container(
                    width: dimension,
                    height: dimension,
                    decoration: BoxDecoration(
                      color: viewModel.allSelectedFilters.keys.firstOrNull ==
                              null
                          ? Colors.black
                          : Color(
                              int.parse(
                                viewModel.allSelectedFilters.keys.firstOrNull!,
                                radix: 16,
                              ),
                            ),
                      shape: BoxShape.circle,
                      boxShadow: const [AppColor.defaultShadow],
                    ),
                  ),
                  overlayPaddingBottom: 36,
                  overlayPaddingTop: 36,
                  contentPaddingRight: 30,
                  contentPaddingLeft: 30,
                  contentPaddingTop: 106,
                  contentPaddingBottom: 106,
                  needOnlyOne: true,
                  options: viewModel.getAllColors(),
                  onSelectionChanged: (filter) =>
                      {viewModel.changeFilterSelection(filter)},
                  filterIsSelect: (filter) => viewModel.haveThisFilter(filter),
                  selectedFilters: viewModel.allSelectedFilters,
                ),
              ],
            ),
            const SizedBox(
              height: textBoxGap,
            ),
            FormattedButton(
              content: LocaleContext.get().client_register_register,
              textColor: Colors.white,
              disabled: viewModel.thereAreErrors,
              onPress: () async => await viewModel.registerCloth(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterClothByQRCode(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: FormattedButton(
          content: "QR Code",
          textColor: AppColor.buttonBackground,
          buttonColor: AppColor.widgetBackground,
          onPress: () {}, //TODO: Create way to do it
        ),
      ),
    );
  }
}
