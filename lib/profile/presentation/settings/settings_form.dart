import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/profile/presentation/settings/settings_view_model.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<SettingsViewModel>(context);
    const Radius borderRadius = Radius.circular(10);

    return Scaffold(
      appBar: StandardHeader(
        title: "Definições",
        sustainablePoints: viewModel.user.sustainablePoints,
      ),
      body: AppBackground(
        content: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GoBack(
            posTop: 18,
            posLeft: 18,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 106, horizontal: 18),
              child: Container(
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
            ),
          ),
        ),
        type: AppBackgrounds.settings,
      ),
    );
  }
}
