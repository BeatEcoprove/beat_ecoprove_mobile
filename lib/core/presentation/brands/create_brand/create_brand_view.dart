import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/presentation/brands/create_brand/create_brand_view_model.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/avatar_chooser/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateBrandView extends LinearView<CreateBrandViewModel> {
  final double firstSectionHeightPercent = 65;

  const CreateBrandView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, CreateBrandViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: StandardHeader(
          title: LocaleContext.get().core_brands_create_brand_register,
          sustainablePoints: 0,
          hasSustainablePoints: false),
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: _buildRegisterForm(context, viewModel)),
        ),
        type: AppBackgrounds.registerClothBackground1,
      ),
    );
  }

  Widget _buildRegisterForm(
      BuildContext context, CreateBrandViewModel viewModel) {
    const double textBoxGap = 12;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
        child: Column(
          children: [
            Column(
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
                      imageProvider: viewModel.getBrandImage(),
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
                    LengthLimitingTextInputFormatter(50),
                  ],
                  onChange: (brandName) async =>
                      viewModel.setBrandName(brandName),
                  initialValue:
                      viewModel.getValue(FormFieldValues.brandName).value,
                  errorMessage:
                      viewModel.getValue(FormFieldValues.brandName).error,
                ),
              ],
            ),
            const SizedBox(
              height: 3 * textBoxGap,
            ),
            FormattedButton(
              content: LocaleContext.get().client_register_register,
              textColor: Colors.white,
              disabled: viewModel.thereAreErrors,
              onPress: () async => await viewModel.registerBrand(),
            )
          ],
        ),
      ),
    );
  }
}
