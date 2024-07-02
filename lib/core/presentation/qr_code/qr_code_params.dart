import 'dart:ui';

class QRCodeParams {
  final String data;
  final String textButton;
  final VoidCallback action;

  QRCodeParams({
    required this.data,
    required this.textButton,
    required this.action,
  });
}
