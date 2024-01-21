import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ResetPasswordViewModel>(context);

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
                        "Redefina a sua palavra-chave",
                        style: AppText.alternativeHeader,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 136,
                      ),
                      DefaultFormattedTextField(
                        hintText: "Palavra-chave",
                        onChange: (password) => viewModel.setPassword(password),
                        initialValue:
                            viewModel.getValue(FormFieldValues.password).value,
                        errorMessage:
                            viewModel.getValue(FormFieldValues.password).error,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DefaultFormattedTextField(
                        hintText: "Confirmar palavra-chave",
                        onChange: (confirmPassword) =>
                            viewModel.setConfirmPassword(confirmPassword),
                        initialValue: viewModel
                            .getValue(FormFieldValues.confirmPassword)
                            .value,
                        errorMessage: viewModel
                            .getValue(FormFieldValues.confirmPassword)
                            .error,
                        isPassword: true,
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
                        buttonColor: AppColor.buttonBackground,
                        textColor: AppColor.widgetBackground,
                        height: 46,
                        onPress: () => {},
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
