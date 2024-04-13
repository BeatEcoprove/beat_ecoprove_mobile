import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class Email {
  static final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );

  final String value;

  Email._(this.value);
  factory Email.create(String email) {
    if (email.isEmpty) {
      throw DomainException(LocaleContext.get().auth_email_insert_pls);
    }

    if (!emailRegex.hasMatch(email)) {
      throw DomainException(LocaleContext.get().auth_email_not_valid);
    }

    return Email._(email);
  }

  @override
  String toString() {
    return value;
  }
}
