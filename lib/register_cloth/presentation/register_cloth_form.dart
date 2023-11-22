import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';

class RegisterClothForm extends StatelessWidget {
  const RegisterClothForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<RegisterClothViewModel>(context);

    return Scaffold(
      appBar: StandardHeader(
          title: "Registar Peça",
          sustainablePoints: viewModel.user.sustainablePoints,
          hasSustainablePoints: false),
      body: AppBackground(
        content: GoBack(
          posTop: 18,
          posLeft: 18,
          child: Stack(
            children: [
              _buildRegisterForm(context),
            ],
          ),
        ),
        type: AppBackgrounds.clothing,
      ),
    );
  }
}

Widget _buildRegisterForm(
  BuildContext context,
) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.topCenter,
      child: Text("A Fazer", style: AppText.titleToScrollSection),
    ),
  );
}
