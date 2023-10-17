import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
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
    final viewModel = ViewModel.of<SignInViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Avatar",
              style: AppText.header,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  FormattedTextField(
                    hintText: "Nome de exibição",
                    onChange: (value) => viewModel.setUserName(value),
                    initialValue: viewModel.userName,
                  ),
                  const SizedBox(
                    height: 54,
                  ),
                  CircleAvatarChooser(
                    height: 200,
                    color: AppColor.widgetSecondary,
                    picturePath: viewModel.avatar,
                    onPress: () => viewModel.setAvatarImage(),
                  )
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
    );
  }
}
