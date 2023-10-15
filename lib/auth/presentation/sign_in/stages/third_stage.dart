import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step.dart';
import 'package:flutter/material.dart';

class ThirdScene extends StatelessWidget {
  static const double textFieldsGap = 26;

  const ThirdScene({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScrollHandler.similiar(
        verticalPadding: 110,
        horizontalPadding: 38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    StepByStep(),
                    Text(
                      "Conta",
                      style: AppText.header,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 78),
                  child: Column(
                    children: [
                      FormattedTextField(
                        hintText: "E-mail",
                      ),
                      SizedBox(
                        height: textFieldsGap,
                      ),
                      FormattedTextField(
                        hintText: "Palavra-chave",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: textFieldsGap,
                      ),
                      FormattedTextField(
                        hintText: "Confirmar palavra-chave",
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FormattedButton(content: "Concluir")
          ],
        ));
  }
}
