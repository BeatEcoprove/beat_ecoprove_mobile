import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class Password {
  final String value;

  Password._(this.value);

  factory Password.create(String password) {
    if (password.isEmpty) {
      throw DomainException(LocaleContext.get().auth_password_must_insert);
    }

    if (!isLengthValid(password)) {
      throw DomainException(LocaleContext.get().auth_password_btw_6_16);
    }

    if (!containsNumber(password)) {
      throw DomainException(
        LocaleContext.get().auth_password_at_least_one_number,
      );
    }

    if (!containsCapitalLetter(password)) {
      throw DomainException(
        LocaleContext.get().auth_password_should_have_at_lest_one_letter,
      );
    }

    if (!containsNonCapitalLetter(password)) {
      throw DomainException(
        LocaleContext.get().auth_password_at_lest_one_caps,
      );
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
