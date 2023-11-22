import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:flutter/material.dart';

class RegisterClothForm extends StatelessWidget {
  //Required: Turn VoidCallBack required
  final VoidCallback? registerByQRCode;

  const RegisterClothForm({
    super.key,
    this.registerByQRCode,
  });

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    final viewModel = ViewModel.of<RegisterClothViewModel>(context);

    return Scaffold(
      appBar: StandardHeader(
          title: "Registar Peça",
          sustainablePoints: viewModel.user.sustainablePoints,
          hasSustainablePoints: false),
      body: Stack(
        children: [
          SizedBox(
            height: maxHeight,
            child: AppBackground(
              content: GoBack(
                posTop: 18,
                posLeft: 18,
                child: _buildRegisterForm(context),
              ),
              type: AppBackgrounds.registerClothBackground1,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 280,
              width: maxWidth,
              child: AppBackground(
                content: _buildRegisterClothByQRCode(context, registerByQRCode),
                type: AppBackgrounds.registerClothBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRegisterForm(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.topCenter,
      child: Text("A Fazer", style: AppText.headerBlack),
    ),
  );
}

Widget _buildRegisterClothByQRCode(
    BuildContext context, VoidCallback? registerByQRCode) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      margin: const EdgeInsets.only(top: 36),
      child: FormattedButton(
        content: "QR Code",
        textColor: AppColor.buttonBackground,
        buttonColor: AppColor.widgetBackground,
        onPress: registerByQRCode,
      ),
    ),
  );
}
