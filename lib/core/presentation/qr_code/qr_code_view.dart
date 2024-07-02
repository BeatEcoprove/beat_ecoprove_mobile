import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/presentation/qr_code/qr_code_params.dart';
import 'package:beat_ecoprove/core/presentation/qr_code/qr_code_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/qr_code/qr_code.dart';
import 'package:flutter/material.dart';

class QRCodeView extends ArgumentView<QRCodeViewModel, QRCodeParams> {
  const QRCodeView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, QRCodeViewModel viewModel) {
    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.closet,
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          onExit: () => viewModel.goBack(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QRCode(
                  data: args.data,
                ),
                FormattedButton(
                  content: args.textButton,
                  textColor: Colors.white,
                  onPress: () => args.action(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
