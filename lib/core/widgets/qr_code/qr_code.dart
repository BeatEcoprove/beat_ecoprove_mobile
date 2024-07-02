import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(5);

  final String data;

  const QRCode({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height / 2;

    return Container(
      height: maxHeight,
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 64,
      ),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [AppColor.defaultShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "QRCode",
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
              ),
              QrImageView(
                data: data,
                version: QrVersions.auto,
                size: maxHeight / 1.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
