import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class FinalStage extends Stage<FinalStageViewModel> {
  static const double textFieldsGap = 26;

  const FinalStage({
    super.key,
    required super.viewModel,
    required super.controller,
  });

  @override
  Widget build(BuildContext context, FinalStageViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Conta",
              style: AppText.header,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  DefaultFormattedTextField(
                    hintText: "E-mail",
                    onChange: (email) => viewModel.setEmail(email),
                    initialValue:
                        viewModel.getValue(FormFieldValues.email).value,
                    errorMessage:
                        viewModel.getValue(FormFieldValues.email).error,
                  ),
                  const SizedBox(
                    height: textFieldsGap,
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
                    height: textFieldsGap,
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
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: "Concluir",
          textColor: Colors.white,
          disabled: viewModel.thereAreErrors,
          onPress: () => controller.nextPage(viewModel.fields),
        )
      ],
    );
  }
}
