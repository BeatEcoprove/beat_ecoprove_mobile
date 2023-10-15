import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

enum FormattedButtonType implements Comparable<FormattedButtonType> {
  normal(color: AppColor.buttonBackground),
  disabled(color: AppColor.disabledColor);

  final Color color;

  const FormattedButtonType({required this.color});

  @override
  int compareTo(FormattedButtonType other) {
    throw UnimplementedError();
  }
}
