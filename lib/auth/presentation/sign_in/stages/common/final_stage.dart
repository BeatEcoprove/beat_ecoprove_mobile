import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:flutter/material.dart';

class FinalStage extends StatelessWidget {
  static const double textFieldsGap = 26;

  const FinalStage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<SignInViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Column(
              children: [
                Text(
                  "Conta",
                  style: AppText.header,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  FormattedTextField(
                    hintText: "E-mail",
                    onChange: (email) => viewModel.setEmail(email),
                    initialValue: viewModel.email,
                  ),
                  const SizedBox(
                    height: textFieldsGap,
                  ),
                  FormattedTextField(
                    hintText: "Palavra-chave",
                    onChange: (password) => viewModel.setPassword(password),
                    initialValue: viewModel.password,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: textFieldsGap,
                  ),
                  FormattedTextField(
                    hintText: "Confirmar palavra-chave",
                    onChange: (confirmPassword) =>
                        viewModel.setConfirmPassword(confirmPassword),
                    initialValue: viewModel.confirmPassword,
                    isPassword: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        const FormattedButton(content: "Concluir")
      ],
    );
  }
}
