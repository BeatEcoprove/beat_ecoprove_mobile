import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/profile/presentation/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: StandardHeader(
        title: "Perfil",
        sustainablePoints: viewModel.user.sustainablePoints,
      ),
      body: Center(
        child: IconButtonRectangular(
          onPress: () async => await viewModel.logout(),
          colorBackground: Colors.red,
          object: const Icon(
            size: 50,
            Icons.exit_to_app_rounded,
            color: AppColor.widgetBackground,
          ),
          dimension: 100,
        ),
      ),
    );
  }
}
