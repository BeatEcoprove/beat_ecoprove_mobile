import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class Name {
  final String firstName;
  final String lastName;

  Name._({required this.firstName, required this.lastName});

  factory Name.create(String firstName, String lastName) {
    if (firstName.isEmpty) {
      throw DomainException(LocaleContext.get().auth_name_insert_first_name);
    }

    if (lastName.isEmpty) {
      throw DomainException(LocaleContext.get().auth_name_insert_last_name);
    }

    if (firstName.contains(" ") && lastName.contains(" ")) {
      throw DomainException(
          LocaleContext.get().auth_name_insert_only_first_and_last);
    }

    return Name._(firstName: firstName, lastName: lastName);
  }

  @override
  String toString() {
    return "$firstName $lastName";
  }
}
