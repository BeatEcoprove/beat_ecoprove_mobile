import 'package:beat_ecoprove/core/widgets/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formated_text_field.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field_type.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  static const double _topPadding = 172;
  static const double _bottomPadding = 44;
  static const double _horizontalPadding = 38;

  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          top: _topPadding,
          bottom: _bottomPadding),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: _calculateScreenHeight(context)),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title
              Text("Title"),
              Column(
                children: [
                  FormattedTextField(
                    fieldType: FormattedTextFieldType.error,
                    hintText: "E-mail",
                    leftIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  SizedBox(height: 16),
                  FormattedTextField(
                    isPassword: true,
                    hintText: "Palavra-Chave",
                    leftIcon: Icon(
                      Icons.lock_outline,
                      color: AppColor.widgetSecondary,
                    ),
                  ),
                  Align(
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
              ),
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
                    ),
                  ],
                ),
              )
            ]),
      ),
    ));
  }

  double _calculateScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - (_topPadding + _bottomPadding);
  }
}
