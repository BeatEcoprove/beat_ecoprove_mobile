import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class PostalCode {
  final String value;
  static final RegExp regex = RegExp(r'^\d{4}-\d{3}$');

  PostalCode._({required this.value});

  factory PostalCode.create(String postalCode) {
    if (!regex.hasMatch(postalCode)) {
      throw DomainException(LocaleContext.get().auth_zip_code_must_7_numbers);
    }

    return PostalCode._(value: postalCode);
  }

  @override
  String toString() {
    return value;
  }
}
