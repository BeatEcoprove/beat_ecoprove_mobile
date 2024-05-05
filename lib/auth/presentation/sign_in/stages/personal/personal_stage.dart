import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/phone_formatted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            Text(
              LocaleContext.get().auth_personal_info,
              style: AppText.header,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  DefaultFormattedTextField(
                    hintText: LocaleContext.get().auth_personal_name,
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(50),
                    ],
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
                      Text(
                        LocaleContext.get().auth_personal_birth_date,
                        softWrap: true,
                        style: const TextStyle(
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
                    countryCodes: viewModel.countryCodes,
                    initialCountryCode: viewModel
                        .getValue(FormFieldValues.phone)
                        .value
                        ?.countryCode,
                    onChangeCountryCode: (countryCode, phone) =>
                        viewModel.setPhone(countryCode, phone),
                    hintText: LocaleContext.get().auth_personal_phone,
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
          content: LocaleContext.get().auth_personal_finish,
          textColor: Colors.white,
          disabled: viewModel.thereAreErrors,
          onPress: () => handleNext(),
        )
      ],
    );
  }
}
