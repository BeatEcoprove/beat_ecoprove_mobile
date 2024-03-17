import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_stage_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/phone_formatted_text_field.dart';
import 'package:flutter/material.dart';

class EnterpriseStage extends Stage<EnterpriseStageViewModel> {
  static const double _textBoxGap = 26;

  const EnterpriseStage({
    super.key,
    required super.viewModel,
    required super.controller,
  });

  @override
  Widget build(BuildContext context, EnterpriseStageViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Informações Do Prestador de Serviço",
              style: AppText.header,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  DefaultFormattedTextField(
                    hintText: 'Nome',
                    onChange: (value) => viewModel.setName(value),
                    initialValue:
                        viewModel.getValue(FormFieldValues.name).value,
                    errorMessage:
                        viewModel.getValue(FormFieldValues.name).error,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedDropDown(
                    options: viewModel.typeOptions,
                    value: viewModel.getValue(FormFieldValues.typeOption).value,
                    onValueChanged: (value) => viewModel.setValue<String>(
                        FormFieldValues.typeOption, value),
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  PhoneFormattedTextField(
                    countryCodes: const {
                      "us": "+1",
                      "pt": "+351",
                      "br": "+55",
                      "es": "+34",
                      "fr": "+33",
                      "it": "+32",
                      "gb": "+31",
                    },
                    initialCountryCode: viewModel
                        .getValue(FormFieldValues.phone)
                        .value
                        ?.countryCode,
                    onChangeCountryCode: (countryCode, phone) =>
                        viewModel.setPhone(countryCode, phone),
                    hintText: "Telemóvel",
                    keyboardType: TextInputType.number,
                    initialValue: viewModel.getDefault(FormFieldValues.phone),
                    errorMessage:
                        viewModel.getValue(FormFieldValues.phone).error,
                  ),
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: "Continuar",
          textColor: Colors.white,
          disabled: viewModel.thereAreErrors,
          onPress: () => handleNext(),
        )
      ],
    );
  }
}
