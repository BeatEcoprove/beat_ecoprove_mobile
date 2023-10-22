import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
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
                  FormattedTextField(
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
                  FormattedTextField(
                    hintText: "Telemóvel",
                    keyboardType: TextInputType.number,
                    onChange: (value) => viewModel.setPhone(value),
                    initialValue: viewModel
                        .getValue(FormFieldValues.phone)
                        .value
                        .toString(),
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
          disabled: viewModel.thereAreErrors,
          onPress: () => handleNextPage(),
        )
      ],
    );
  }
}
