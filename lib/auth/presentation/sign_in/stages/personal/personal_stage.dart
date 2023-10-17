import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
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
    final SignInController flowController = Provider.of(context);
    final viewModel = ViewModel.of<SignInViewModel>(context);

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
                    errorMessage: viewModel.nameError,
                    onChange: (value) => viewModel.setName(value),
                    initialValue: viewModel.name,
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
                        value: viewModel.bornDate,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedDropDown(
                    options: Gender.getAllTypes(),
                    value: viewModel.gender,
                    onValueChanged: (value) => viewModel.setGender(value),
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedTextField(
                    hintText: "Telemóvel",
                    keyboardType: TextInputType.number,
                    onChange: (value) =>
                        viewModel.setPhone("+351", value.toString()),
                    initialValue: viewModel.phone,
                    errorMessage: viewModel.phoneError,
                  ),
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: "Concluir",
          onPress: () => flowController.nextPage(),
        )
      ],
    );
  }
}
