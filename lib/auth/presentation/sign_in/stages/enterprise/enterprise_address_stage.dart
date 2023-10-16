import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterpriseAddressStage extends StatefulWidget {
  const EnterpriseAddressStage({super.key});

  @override
  State<EnterpriseAddressStage> createState() => _EnterpriseAddressStageState();
}

class _EnterpriseAddressStageState extends State<EnterpriseAddressStage> {
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
            const Column(
              children: [
                Column(
                  children: [
                    StepByStep(),
                    SizedBox(
                      height: 36,
                    ),
                    Text(
                      "Morada",
                      style: AppText.header,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 78),
                  child: Column(
                    children: [
                      FormattedDropDown(
                        options: ["Portugal", "Espanhã", "França"],
                      ),
                      SizedBox(
                        height: _textBoxGap,
                      ),
                      FormattedDropDown(
                        options: ["Póvoa de Varzim", "Vila do Conde", "Porto"],
                      ),
                      SizedBox(
                        height: _textBoxGap,
                      ),
                      FormattedTextField(
                        hintText: "Rua",
                      ),
                      SizedBox(
                        height: _textBoxGap,
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
