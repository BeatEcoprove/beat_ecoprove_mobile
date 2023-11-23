import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_brand.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_size.dart';
import 'package:beat_ecoprove/register_cloth/domain/value_objects/cloth_type.dart';
import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterClothForm extends StatelessWidget {
  const RegisterClothForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    final viewModel = ViewModel.of<RegisterClothViewModel>(context);

    return Scaffold(
      appBar: StandardHeader(
          title: "Registar Peça",
          sustainablePoints: viewModel.user.sustainablePoints,
          hasSustainablePoints: false),
      body: Stack(
        children: [
          SizedBox(
            height: maxHeight - 280,
            child: AppBackground(
              content: GoBack(
                posTop: 18,
                posLeft: 18,
                child: _buildRegisterForm(context, viewModel),
              ),
              type: AppBackgrounds.registerClothBackground1,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 200,
              width: maxWidth,
              child: AppBackground(
                content: _buildRegisterClothByQRCode(context),
                type: AppBackgrounds.registerClothBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRegisterForm(
    BuildContext context, RegisterClothViewModel viewModel) {
  const double _textBoxGap = 12;

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Imagem",
                style: AppText.subHeader,
              ),
              const SizedBox(
                width: 12,
              ),
              CircleAvatarChooser(
                height: 120,
                color: AppColor.widgetSecondary,
                imageProvider: viewModel.getClothImage(),
                onPress: () => viewModel.getImageFromGallery(),
              ),
            ],
          ),
          const SizedBox(
            height: _textBoxGap,
          ),
          DefaultFormattedTextField(
            hintText: "Nome",
            inputFormatter: [
              LengthLimitingTextInputFormatter(18),
            ],
            onChange: (clothName) async => viewModel.setClothName(clothName),
            initialValue: viewModel.getValue(FormFieldValues.clothName).value,
            errorMessage: viewModel.getValue(FormFieldValues.clothName).error,
          ),
          const SizedBox(
            height: _textBoxGap,
          ),
          FormattedDropDown(
            options: ClothType.getAllTypes(),
            value: viewModel.getValue(FormFieldValues.clothType).value,
            onValueChanged: (value) =>
                viewModel.setValue(FormFieldValues.clothType, value),
          ),
          const SizedBox(
            height: _textBoxGap,
          ),
          FormattedDropDown(
            options: ClothSize.getAllTypes(),
            value: viewModel.getValue(FormFieldValues.clothSize).value,
            onValueChanged: (value) =>
                viewModel.setValue(FormFieldValues.clothSize, value),
          ),
          const SizedBox(
            height: _textBoxGap,
          ),
          FormattedDropDown(
            options: ClothBrand.getAllTypes(),
            value: viewModel.getValue(FormFieldValues.clothBrand).value,
            onValueChanged: (value) =>
                viewModel.setValue(FormFieldValues.clothBrand, value),
          ),
          const SizedBox(
            height: _textBoxGap,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Cor",
                style: AppText.subHeader,
              ),
              const SizedBox(
                width: 12,
              ),
              IconButtonRectangular(
                object: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    boxShadow: [AppColor.defaultShadow],
                  ),
                ),
                isCircular: true,
                dimension: 50,
              ),
            ],
          ),
          const SizedBox(
            height: _textBoxGap,
          ),
          FormattedButton(
            content: "Registar",
            textColor: Colors.white,
            disabled: viewModel.thereAreErrors,
            onPress: () {
              viewModel.registerCloth();
            },
          )
        ],
      ),
    ),
  );
}

Widget _buildRegisterClothByQRCode(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      margin: const EdgeInsets.only(top: 16),
      child: FormattedButton(
        content: "QR Code",
        textColor: AppColor.buttonBackground,
        buttonColor: AppColor.widgetBackground,
        onPress: () {}, //Required: Create way to do it
      ),
    ),
  );
}
