import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EnterpriseStage extends StatefulWidget {
  const EnterpriseStage({super.key});

  @override
  State<EnterpriseStage> createState() => _EnterpriseStageState();
}

class _EnterpriseStageState extends State<EnterpriseStage> {
  static const double _textBoxGap = 26;

  @override
  Widget build(BuildContext context) {
    final SignInController signController = Provider.of(context);

    return ScrollHandler.similiar(
        verticalPadding: 110,
        horizontalPadding: 38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Column(
                  children: [
                    StepByStep(),
                    SizedBox(
                      height: 36,
                    ),
                    Text(
                      "Informações Do Prestador de Serviço",
                      style: AppText.header,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 78),
                  child: Column(
                    children: [
                      const FormattedTextField(
                        hintText: 'Nome',
                      ),
                      const SizedBox(
                        height: _textBoxGap,
                      ),
                      const FormattedDropDown(
                        options: ["Lavandaria", "Reparador", "Reciclador"],
                      ),
                      const SizedBox(
                        height: _textBoxGap,
                      ),
                      FormattedTextField(
                        hintText: "telemóvel",
                        keyboardType: TextInputType.number,
                        inputFormatter: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Onl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FormattedButton(
              content: "Continuar",
              onPress: () => signController.nextPage(),
            )
          ],
        ));
  }
}
