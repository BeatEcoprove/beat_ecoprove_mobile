import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
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
            Text(
              LocaleContext.get().auth_final_stage_account,
              style: AppText.header,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  DefaultFormattedTextField(
                    hintText: LocaleContext.get().auth_final_stage_email,
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
                    hintText: LocaleContext.get().auth_final_stage_password,
                    onChange: (password) => viewModel.setPassword(password),
                    initialValue:
                        viewModel.getValue(FormFieldValues.password).value,
                    errorMessage:
                        viewModel.getValue(FormFieldValues.password).error,
                    isPassword: !viewModel.isPassword,
                  ),
                  const SizedBox(
                    height: textFieldsGap,
                  ),
                  DefaultFormattedTextField(
                    hintText:
                        LocaleContext.get().auth_final_stage_confirm_password,
                    onChange: (confirmPassword) =>
                        viewModel.setConfirmPassword(confirmPassword),
                    initialValue: viewModel
                        .getValue(FormFieldValues.confirmPassword)
                        .value,
                    errorMessage: viewModel
                        .getValue(FormFieldValues.confirmPassword)
                        .error,
                    isPassword: !viewModel.isPassword,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Checkbox(
                    value: viewModel.isPassword,
                    activeColor: AppColor.darkGreen,
                    onChanged: (value) =>
                        viewModel.setPasswordVisibitlity(value),
                  ),
                  const Text("Mostrar palavra-chave"),
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: LocaleContext.get().auth_final_stage_finish,
          textColor: Colors.white,
          disabled: viewModel.thereAreErrors,
          loading: viewModel.isLoading,
          onPress: () async => viewModel.handleSignIn(controller),
        )
      ],
    );
  }
}
