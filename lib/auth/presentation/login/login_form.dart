import 'package:beat_ecoprove/core/widgets/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formated_text_field.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Title
          Flexible(child: Spacer()),
          FormatedTextField(
            hintText: "E-mail",
            leftIcon: Icon(
              Icons.email_outlined,
              color: AppColor.widgetSecondary,
            ),
          ),
          SizedBox(height: 16),
          FormatedTextField(
            hintText: "Palavra-Chave",
            leftIcon: Icon(
              Icons.lock_outline,
              color: AppColor.widgetSecondary,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Text("Esqueceu-se da Palavra-chave?",
                  style: AppText.underlineStyle),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          FormatedButton(
            content: "Entrar",
          ),
          Flexible(child: Spacer()),
          // Footer
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não tem Conta?", style: AppText.strongStyle),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Registar",
                  style: AppText.underlineStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
