import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class UserNameInvite {
  final String name;

  UserNameInvite._(this.name);

  factory UserNameInvite.create(String userNameInvite) {
    if (userNameInvite.isEmpty) {
      throw DomainException(LocaleContext.get().group_domain_username);
    }

    return UserNameInvite._(userNameInvite);
  }

  @override
  String toString() {
    return name;
  }
}
