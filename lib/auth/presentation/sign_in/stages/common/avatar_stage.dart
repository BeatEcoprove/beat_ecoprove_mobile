import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/choose_avatar.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarStage extends StatefulWidget {
  const AvatarStage({super.key});

  @override
  State<AvatarStage> createState() => AvatarStageState();
}

class AvatarStageState extends State<AvatarStage> {
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
            const Column(
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
            FormattedButton(
              content: "Continuar",
              onPress: () => signController.nextPage(),
            )
          ],
        ));
  }
}
