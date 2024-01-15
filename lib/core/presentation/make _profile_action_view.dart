import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item_user.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/profile/contracts/profile_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MakeProfileActionViewParams {
  final ProfileResult profile;
  final String text;
  final String textButton;
  final VoidCallback action;

  MakeProfileActionViewParams({
    required this.profile,
    required this.text,
    required this.textButton,
    required this.action,
  });
}

class MakeProfileActionView extends StatelessWidget {
  final MakeProfileActionViewParams params;

  const MakeProfileActionView({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.completed,
        content: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      params.text,
                      style: AppText.alternativeHeader,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 62,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CompactListItemUser.withoutOptions(
                      title: params.profile.username,
                      userLevel: params.profile.level,
                      sustainablePoints: params.profile.sustainabilityPoints,
                      //TODO: CHANGE TO ECOSCORE
                      ecoScorePoints: params.profile.sustainabilityPoints,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                ),
                Column(
                  children: [
                    FormattedButton(
                      content: params.textButton,
                      buttonColor: AppColor.buttonBackground,
                      textColor: AppColor.widgetBackground,
                      height: 46,
                      onPress: () => {
                        params.action(),
                      },
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    FormattedButton(
                      content: "Cancelar",
                      buttonColor: AppColor.widgetBackground,
                      textColor: AppColor.black,
                      height: 46,
                      onPress: () => router.pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
