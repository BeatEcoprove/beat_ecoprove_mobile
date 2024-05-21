import 'package:flutter/services.dart';

class PostalCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '',
      );
    }

    final cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');
    final formattedText = _formatPostalCode(cleanText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPostalCode(String input) {
    if (input.length <= 4) {
      return input;
    }

    return '${input.substring(0, 4)}-${input.substring(4)}';
  }
}
