import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late LoginViewModel _viewModel;

  static const double _topPadding = 172;
  static const double _bottomPadding = 44;
  static const double _horizontalPadding = 38;

  @override
  Widget build(BuildContext context) {
    _viewModel = ViewModel.of<LoginViewModel>(context);

    return ScrollHandler(
      topPadding: _topPadding,
      bottomPadding: _bottomPadding,
      leftPadding: _horizontalPadding,
      rightPadding: _horizontalPadding,
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SvgImage(
                path: "assets/applicationTitle.svg",
                heigth: 74.23,
                width: 224,
              ),
              Column(
                children: [
                  FormattedTextField(
                    hintText: "E-mail",
                    leftIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    errorMessage: _viewModel.emailError,
                    onChange: (value) {
                      setState(() {
                        _viewModel.setEmail(value);
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  FormattedTextField(
                    isPassword: true,
                    hintText: "Palavra-chave",
                    leftIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColor.widgetSecondary,
                    ),
                    errorMessage: _viewModel.passwordError,
                    onChange: (value) {
                      setState(() {
                        _viewModel.setPassword(value);
                      });
                    },
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Text("Esqueceu-se da Palavra-chave?",
                          style: AppText.underlineStyle),
                    ),
                  ),
                ],
              ),
              FormattedButton(
                content: "Entrar",
                onPress: () async {
                  _viewModel.handleLogin();
                },
                disabled: !_viewModel.canHandleLogin,
                loading: _viewModel.isLoading,
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
                      onTap: () {
                        context.go("/select-user");
                      },
                      child: const Text(
                        "Registar",
                        style: AppText.underlineStyle,
                      ),
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
