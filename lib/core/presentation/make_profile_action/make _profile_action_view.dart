import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make_profile_action_params.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make_profile_action_view_model.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/profile_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:flutter/material.dart';

class MakeProfileActionView extends ArgumentedView<MakeProfileActionViewModel,
    MakeProfileActionViewParams> {
  const MakeProfileActionView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, MakeProfileActionViewModel viewModel) {
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
                      args.text,
                      style: AppText.alternativeHeader,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 62,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CompactListItemRoot(
                      height: HeightCard.height88,
                      padding: PaddingCard.padding0,
                      items: [
                        ProfileHeader(
                          title: args.profile.username,
                          userLevel: args.profile.level,
                          sustainablePoints: args.profile.sustainabilityPoints,
                          ecoScorePoints: args.profile.ecoScorePoints,
                        ),
                        const WithoutOptionsFooter(),
                      ],
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                ),
                Column(
                  children: [
                    FormattedButton(
                      content: args.textButton,
                      buttonColor: AppColor.buttonBackground,
                      textColor: AppColor.widgetBackground,
                      height: 46,
                      onPress: () => {
                        args.action(),
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
                      onPress: () => viewModel.goBack(),
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
