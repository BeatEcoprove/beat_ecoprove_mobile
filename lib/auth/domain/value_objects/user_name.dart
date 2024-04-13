import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class UserName {
  final String value;

  UserName._(this.value);

  factory UserName.create(String userName) {
    if (userName.isEmpty) {
      throw DomainException(LocaleContext.get().auth_username_insert_it);
    }

    return UserName._(userName);
  }

  @override
  String toString() {
    return value;
  }
}
