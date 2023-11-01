import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
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
    final formattedText = _formatPhoneNumber(cleanText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPhoneNumber(String input) {
    if (input.length <= 3) {
      return input;
    } else if (input.length <= 6) {
      return '${input.substring(0, 3)} ${input.substring(3)}';
    } else {
      return '${input.substring(0, 3)} ${input.substring(3, 6)} ${input.substring(6)}';
    }
  }
}
