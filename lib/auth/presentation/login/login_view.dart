import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class LoginView extends IView<LoginViewModel> {
  static const double _topPadding = 172;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SvgImage(
                  path: "assets/applicationTitle.svg",
                  height: 74.23,
                  width: 224,
                ),
                Column(
                  children: [
                    DefaultFormattedTextField(
                      hintText: "E-mail",
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
                      isPassword: true,
                      hintText: "Palavra-chave",
                      leftIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColor.widgetSecondary,
                      ),
                      initialValue:
                          viewModel.getValue(FormFieldValues.password).value,
                      errorMessage:
                          viewModel.getValue(FormFieldValues.password).error,
                      onChange: (value) => viewModel.setPassword(value),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: GestureDetector(
                          onTap: () async =>
                              await viewModel.handleForgotPassword(),
                          child: const Text(
                            "Esqueceu-se da Palavra-chave?",
                            style: AppText.underlineStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                FormattedButton(
                  content: "Entrar",
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
                      const Text("Não tem Conta?", style: AppText.strongStyle),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () => viewModel.handleSignUp(),
                        child: const Text(
                          "Registar",
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
