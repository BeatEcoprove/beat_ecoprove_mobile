import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/choose_avatar.dart';
import 'package:beat_ecoprove/core/widgets/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step.dart';
import 'package:flutter/material.dart';

class SecondStage extends StatefulWidget {
  const SecondStage({super.key});

  @override
  State<SecondStage> createState() => SecondStageState();
}

class SecondStageState extends State<SecondStage> {
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
                StepByStep(),
                SizedBox(
                  height: SignInView.headerGap,
                ),
                Text(
                  "Avatar",
                  style: AppText.header,
                ),
              ],
            ),
            Column(
              children: [
                FormattedTextField(
                  hintText: "Nome de exibição",
                ),
                SizedBox(
                  height: 54,
                ),
                ChooseAvatar()
              ],
            ),
            FormattedButton(content: "Continuar")
          ],
        ));
  }
}
