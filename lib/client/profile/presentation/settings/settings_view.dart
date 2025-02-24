import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/profile/domain/value_objects/language.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/settings_view_model.dart';
import 'package:flutter/material.dart';

class SettingsView extends LinearView<SettingsViewModel> {
  const SettingsView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    const Radius borderRadius = Radius.circular(10);
    var totalWidth = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      appBar: StandardHeader(
        title: "Definições",
        sustainablePoints: viewModel.user?.sustainablePoints ?? 0,
      ),
      body: GoBack(
        posLeft: 18,
        posTop: 18,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: AppBackground(
            content: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 106, horizontal: 18),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 75,
                    decoration: const BoxDecoration(
                      color: AppColor.widgetBackground,
                      borderRadius: BorderRadius.all(borderRadius),
                      boxShadow: [AppColor.defaultShadow],
                    ),
                    child: InkWell(
                      onTap: () => viewModel.sendFeedback(),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Enviar Feedback",
                              textAlign: TextAlign.start,
                              style: AppText.firstHeader,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.widgetSecondary,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 75,
                    decoration: const BoxDecoration(
                      color: AppColor.widgetBackground,
                      borderRadius: BorderRadius.all(borderRadius),
                      boxShadow: [AppColor.defaultShadow],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: totalWidth,
                          child: Text(
                            LocaleContext.get().profile_settings_language,
                            textAlign: TextAlign.start,
                            style: AppText.firstHeader,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: totalWidth + 20,
                          height: 75,
                          child: FormattedDropDown(
                            options: Language.getAllLanguages()
                                .map((e) => e.displayValue)
                                .toList(),
                            value: viewModel
                                .getValue(FormFieldValues.language)
                                .value
                                .toString(),
                            onValueChanged: (value) =>
                                viewModel.changeLanguage(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 75,
                    decoration: const BoxDecoration(
                      color: AppColor.endSession,
                      borderRadius: BorderRadius.all(borderRadius),
                      boxShadow: [AppColor.defaultShadow],
                    ),
                    child: InkWell(
                      onTap: () async => await viewModel.logout(),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Terminar Sessão",
                              textAlign: TextAlign.center,
                              style: AppText.firstHeaderWhite,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            type: AppBackgrounds.settings,
          ),
        ),
      ),
    );
  }
}
