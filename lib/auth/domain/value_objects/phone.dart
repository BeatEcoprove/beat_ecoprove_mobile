import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class Phone {
  final String countryCode;
  final String value;

  Phone._({required this.countryCode, required this.value});

  factory Phone.create(String code, String phone) {
    phone = phone.replaceAll(" ", "").trim();

    // must have 9 characters long
    if (phone.length != 9) {
      throw DomainException(LocaleContext.get().auth_phone_must_9_numbers);
    }

    // must be numbers
    try {
      int.parse(phone);
    } catch (e) {
      throw DomainException(LocaleContext.get().auth_phone_must_9_numbers);
    }

    return Phone._(countryCode: code, value: formatPhoneNumber(phone));
  }

  @override
  String toString() => value;

  String get contryCode => countryCode;

  static String formatPhoneNumber(String phone) {
    String formattedPhone = '';

    for (var i = 0; i < phone.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formattedPhone += ' ';
      }

      formattedPhone += phone[i];
    }

    return formattedPhone;
  }
}
