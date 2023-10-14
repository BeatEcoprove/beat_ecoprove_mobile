import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

enum FormattedTextFieldType implements Comparable<FormattedTextFieldType> {
  normal(color: Colors.transparent, focusColor: AppColor.primaryColor),
  error(color: Colors.redAccent, focusColor: Colors.redAccent);

  final Color color;
  final Color focusColor;

  const FormattedTextFieldType({required this.color, required this.focusColor});

  @override
  int compareTo(FormattedTextFieldType other) {
    throw UnimplementedError();
  }
}
