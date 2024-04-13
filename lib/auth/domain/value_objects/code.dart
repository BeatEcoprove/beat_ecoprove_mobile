import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class Code {
  final int length = 6;
  final String value;

  Code._(this.value);

  factory Code.create(String code) {
    if (code.isEmpty) {
      throw DomainException(LocaleContext.get().auth_code_is_empty);
    }

    if (code.length != 6) {
      throw DomainException(LocaleContext.get().auth_code_should_have_6_digits);
    }

    return Code._(code);
  }

  @override
  String toString() {
    return value;
  }
}
