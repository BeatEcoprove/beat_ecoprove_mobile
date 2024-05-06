import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_check_box.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class LoginView extends LinearView<LoginViewModel> {
  static const double _topPadding = 116;
  static const double _bottomPadding = 44;
  static const double _horizontalPadding = 38;

  const LoginView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        type: AppBackgrounds.login,
        content: ScrollHandler(
          topPadding: _topPadding,
          bottomPadding: _bottomPadding,
          leftPadding: _horizontalPadding,
          rightPadding: _horizontalPadding,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SvgImage(
                  path: "assets/applicationTitle.svg",
                  height: 74.23,
                  width: 224,
                ),
                Column(
                  children: [
                    DefaultFormattedTextField(
                      hintText: LocaleContext.get().auth_login_email,
                      leftIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      initialValue:
                          viewModel.getValue(FormFieldValues.email).value,
                      errorMessage:
                          viewModel.getValue(FormFieldValues.email).error,
                      onChange: (value) => viewModel.setEmail(value),
                    ),
                    const SizedBox(height: 16),
                    DefaultFormattedTextField(
                      isPassword: !viewModel.isPassword,
                      hintText: LocaleContext.get().auth_login_password,
                      leftIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColor.widgetSecondary,
                      ),
                      controller: viewModel.passwordTextController,
                      initialValue:
                          viewModel.getValue(FormFieldValues.password).value,
                      errorMessage:
                          viewModel.getValue(FormFieldValues.password).error,
                      onChange: (value) => viewModel.setPassword(value),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormattedCheckBox(
                        value: viewModel.isPassword,
                        onChanged: viewModel.setPasswordVisibitlity,
                        title: "Mostrar palavra-chave",
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: GestureDetector(
                          onTap: () async =>
                              await viewModel.handleForgotPassword(),
                          child: Text(
                            LocaleContext.get().auth_login_forgot_password,
                            style: AppText.underlineStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                FormattedButton(
                  content: LocaleContext.get().auth_login_sign_in,
                  textColor: Colors.white,
                  onPress: () async {
                    viewModel.handleLogin();
                  },
                  disabled: viewModel.thereAreErrors,
                  loading: viewModel.isLoading,
                ),
                // Footer
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleContext.get().auth_login_got_no_account,
                          style: AppText.strongStyle),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () => viewModel.handleSignUp(),
                        child: Text(
                          LocaleContext.get().auth_login_sign_up,
                          style: AppText.underlineStyle,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
