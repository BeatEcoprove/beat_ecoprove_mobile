import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_params.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_check_box.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordView
    extends ArgumentView<ResetPasswordViewModel, ResetPasswordParams> {
  const ResetPasswordView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ResetPasswordViewModel viewModel) {
    return Scaffold(
      body: AppBackground(
        content: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GoBack(
            posTop: 18,
            posLeft: 18,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 86,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            LocaleContext.get()
                                .auth_forgot_password_reset_password_new_password,
                            style: AppText.alternativeHeader,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 136,
                          ),
                          DefaultFormattedTextField(
                            hintText: LocaleContext.get()
                                .auth_forgot_password_reset_password_password,
                            onChange: (password) =>
                                viewModel.setPassword(password),
                            initialValue: viewModel
                                .getValue(FormFieldValues.password)
                                .value,
                            errorMessage: viewModel
                                .getValue(FormFieldValues.password)
                                .error,
                            isPassword: !viewModel.isPassword,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DefaultFormattedTextField(
                            hintText: LocaleContext.get()
                                .auth_forgot_password_reset_password_confirm_password,
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
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: FormattedCheckBox(
                              value: viewModel.isPassword,
                              onChanged: viewModel.setPasswordVisibitlity,
                              title: LocaleContext.get()
                                  .auth_forgot_password_reset_password_show_password,
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
                            content: LocaleContext.get()
                                .auth_forgot_password_reset_password_continue,
                            textColor: AppColor.widgetBackground,
                            disabled: viewModel.thereAreErrors,
                            height: 46,
                            onPress: () =>
                                viewModel.handleRefreshPassword(args.code),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        type: AppBackgrounds.login,
      ),
    );
  }
}
