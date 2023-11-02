import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/phone_formatted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalStage extends StatefulWidget {
  const PersonalStage({Key? key}) : super(key: key);

  @override
  State<PersonalStage> createState() => _PersonalStageState();
}

class _PersonalStageState extends State<PersonalStage> {
  static const double _textBoxGap = 26;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context);
    final viewModel = ViewModel.of<PersonalViewModel>(context);

    void handleNextPage() {
      controller.nextPage(viewModel.fields);
    }

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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedDropDown(
                    options: Gender.getAllTypes(),
                    value: viewModel.getValue(FormFieldValues.gender).value,
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
                      "it": "+33",
                      "gb": "+33",
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
          onPress: () => handleNextPage(),
        )
      ],
    );
  }
}
