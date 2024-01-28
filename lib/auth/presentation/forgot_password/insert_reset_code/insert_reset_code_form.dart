import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InsertResetCodeForm extends StatelessWidget {
  const InsertResetCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InsertResetCodeViewModel>(context);
    // viewModel.sendCode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Foi enviado um código para o seu email",
                        style: AppText.smallHeader,
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Coloque o código enviado para o seu email",
                        style: AppText.smallSubHeader,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 136,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: DefaultFormattedTextField(
                          hintText: "Código",
                          keyboardType: TextInputType.number,
                          initialValue:
                              viewModel.getValue(FormFieldValues.email).value,
                          errorMessage:
                              viewModel.getValue(FormFieldValues.email).error,
                          onChange: (value) => viewModel.setCode(value),
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(6),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FormattedButton(
                        content: "Continuar",
                        textColor: Colors.white,
                        onPress: () async {
                          viewModel.verifyCode();
                        },
                        disabled: viewModel.thereAreErrors,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        type: AppBackgrounds.login,
      ),
    );
  }
}
