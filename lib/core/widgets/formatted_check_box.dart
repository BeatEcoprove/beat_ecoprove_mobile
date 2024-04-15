import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FormattedCheckBox extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const FormattedCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: AppColor.darkGreen,
          onChanged: (value) => onChanged(value!),
        ),
        Text(title),
      ],
    );
  }
}
