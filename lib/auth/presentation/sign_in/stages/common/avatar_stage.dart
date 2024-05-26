import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/avatar_stage_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/stage.dart';
import 'package:beat_ecoprove/core/widgets/avatar_chooser/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AvatarStage extends Stage<AvatarStageViewModel> {
  const AvatarStage({
    super.key,
    required super.viewModel,
    required super.controller,
  });

  @override
  Widget build(BuildContext context, AvatarStageViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              LocaleContext.get().auth_avatar_avatar,
              style: AppText.header,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  DefaultFormattedTextField(
                    hintText: LocaleContext.get().auth_avatar_username,
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    onChange: (value) async =>
                        await viewModel.setUserName(value),
                    initialValue:
                        viewModel.getValue(FormFieldValues.userName).value,
                    errorMessage:
                        viewModel.getValue(FormFieldValues.userName).error,
                  ),
                  const SizedBox(
                    height: 54,
                  ),
                  CircleAvatarChooser(
                    height: 200,
                    color: AppColor.widgetSecondary,
                    imageProvider: viewModel.getAvatarImage(),
                    onPress: () => viewModel.getImageFromGallery(),
                  )
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: LocaleContext.get().auth_avatar_finish,
          textColor: Colors.white,
          disabled: viewModel.thereAreErrors,
          onPress: () => handleNext(),
        )
      ],
    );
  }
}
