import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:flutter/material.dart';

class InsertResetCodeForm extends StatelessWidget {
  const InsertResetCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InsertResetCodeViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      Text(
                        "Coloque o código enviado para o seu email",
                        style: AppText.alternativeHeader,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 136,
                      ),
                      Text("Caixas de Texto"),
                      SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      FormattedButton(
                        content: "Continuar",
                        buttonColor: AppColor.buttonBackground,
                        textColor: AppColor.widgetBackground,
                        height: 46,
                        onPress: () => {
                          viewModel.verifyCode(),
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        type: AppBackgrounds.settings,
      ),
    );
  }
}
