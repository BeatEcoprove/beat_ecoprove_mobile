import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class Password {
  final String value;

  Password._(this.value);

  factory Password.create(String password) {
    if (!isLengthValid(password)) {
      throw DomainException("A palavra-chave deve ter entre 6 a 16 caracteres");
    }

    if (!containsNumber(password)) {
      throw DomainException("A palavra-chave deve conter pelo menos 1 número");
    }

    if (!containsCapitalLetter(password)) {
      throw DomainException(
          "A palavra-chave deve conter pelo menos um letra maiúscula");
    }

    if (!containsNonCapitalLetter(password)) {
      throw DomainException(
          "A palavra-chave deve conter pelo menos um letra minúscula");
    }

    return Password._(password);
  }

  static bool isLengthValid(String password) {
    return password.length >= 6 && password.length <= 16;
  }

  static bool containsNumber(String password) {
    final RegExp digitRegex = RegExp(r'[0-9]');
    return digitRegex.hasMatch(password);
  }

  static bool containsCapitalLetter(String password) {
    final RegExp capitalLetterRegex = RegExp(r'[A-Z]');
    return capitalLetterRegex.hasMatch(password);
  }

  static bool containsNonCapitalLetter(String password) {
    final RegExp nonCapitalLetterRegex = RegExp(r'[a-z]');
    return nonCapitalLetterRegex.hasMatch(password);
  }

  @override
  String toString() {
    return value;
  }
}
