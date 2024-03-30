import 'dart:ui';

import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';

class MakeProfileActionViewParams {
  final ProfileResult profile;
  final String text;
  final String textButton;
  final VoidCallback action;

  MakeProfileActionViewParams({
    required this.profile,
    required this.text,
    required this.textButton,
    required this.action,
  });
}
