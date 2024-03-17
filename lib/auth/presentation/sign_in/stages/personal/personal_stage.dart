import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/phone_formatted_text_field.dart';
import 'package:flutter/material.dart';

class PersonalStage extends Stage<PersonalViewModel> {
  static const double _textBoxGap = 26;

  const PersonalStage({
    super.key,
    required super.viewModel,
    required super.controller,
  });

  @override
  Widget build(BuildContext context, PersonalViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Informações Pessoais",
              style: AppText.header,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  DefaultFormattedTextField(
                    hintText: 'Nome',
                    errorMessage:
                        viewModel.getValue(FormFieldValues.name).error,
                    onChange: (value) => viewModel.setName(value),
                    initialValue:
                        viewModel.getValue(FormFieldValues.name).value,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Data de Nascimento",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: AppText.title5,
                          color: AppColor.widgetSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DatePicker(
                        value:
                            viewModel.getValue(FormFieldValues.bornDate).value,
                        onDateChanged: (date) => viewModel.setDate(date),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedDropDown(
                    options: Gender.getAllTypes()
                        .map((e) => e.displayValue)
                        .toList(),
                    value: viewModel
                        .getValue(FormFieldValues.gender)
                        .value
                        .toString(),
                    onValueChanged: (value) =>
                        viewModel.setValue(FormFieldValues.gender, value),
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
                    initialValue:
                        viewModel.getDefault<String>(FormFieldValues.phone),
                    errorMessage:
                        viewModel.getValue(FormFieldValues.phone).error,
                  ),
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: "Concluir",
          textColor: Colors.white,
          disabled: viewModel.thereAreErrors,
          onPress: () => handleNext(),
        )
      ],
    );
  }
}
