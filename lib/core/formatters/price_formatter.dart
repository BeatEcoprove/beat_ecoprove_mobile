import 'package:flutter/services.dart';

class PriceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final validCharacters = RegExp(r'^[0-9]*\.?[0-9]*$');
    if (!validCharacters.hasMatch(newValue.text)) {
      return oldValue;
    }

    if (newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
      return oldValue;
    }

    try {
      double.parse(newValue.text);
    } catch (e) {
      return oldValue;
    }

    return newValue;
  }
}
