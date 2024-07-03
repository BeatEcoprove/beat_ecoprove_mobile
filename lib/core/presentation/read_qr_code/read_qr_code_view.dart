import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/presentation/read_qr_code/read_qr_code_params.dart';
import 'package:beat_ecoprove/core/presentation/read_qr_code/read_qr_code_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ReadQRCodeView
    extends ArgumentView<ReadQRCodeViewModel, ReadQRCodeParams> {
  const ReadQRCodeView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ReadQRCodeViewModel viewModel) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    double maxWidth = MediaQuery.of(context).size.width / 1.5;

    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.closet,
        content: GoBack(
          posLeft: 18,
          posTop: 18,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 106),
                  child: SizedBox(
                    height: maxWidth,
                    width: maxWidth,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: viewModel.onQRViewCreated,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
