import 'package:beat_ecoprove/auth/validators/validation_exception.dart';
import 'package:beat_ecoprove/auth/validators/validator.dart';

class PasswordValidator implements Validator<String> {
  bool isLengthValid(String password) {
    return password.length >= 6 && password.length <= 16;
  }

  bool containsNumber(String password) {
    final RegExp digitRegex = RegExp(r'[0-9]');
    return digitRegex.hasMatch(password);
  }

  bool containsCapitalLetter(String password) {
    final RegExp capitalLetterRegex = RegExp(r'[A-Z]');
    return capitalLetterRegex.hasMatch(password);
  }

  bool containsNonCapitalLetter(String password) {
    final RegExp nonCapitalLetterRegex = RegExp(r'[a-z]');
    return nonCapitalLetterRegex.hasMatch(password);
  }

  @override
  bool validate(String password) {
    if (!isLengthValid(password)) {
      throw ValidationException(
          "A palavra-chave deve ter entre 6 a 16 caracteres");
    }

    if (!containsNumber(password)) {
      throw ValidationException(
          "A palavra-chave deve conter pelo menos 1 número");
    }

    if (!containsCapitalLetter(password)) {
      throw ValidationException(
          "A palavra-chave deve conter pelo menos um letra maiúscula");
    }

    if (!containsNonCapitalLetter(password)) {
      throw ValidationException(
          "A palavra-chave deve conter pelo menos um letra minúscula");
    }

    return true;
  }
}
