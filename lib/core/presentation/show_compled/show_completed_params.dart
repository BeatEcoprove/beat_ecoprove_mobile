import 'dart:ui';

class ShowCompletedViewParams {
  final String text;
  final String textButton;
  final VoidCallback action;

  ShowCompletedViewParams({
    required this.text,
    required this.textButton,
    required this.action,
  });
}
