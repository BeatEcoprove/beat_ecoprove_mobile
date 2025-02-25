import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class ProfileUserName {
  final String name;

  ProfileUserName._(this.name);

  factory ProfileUserName.create(String profileUserName) {
    if (profileUserName.isEmpty) {
      throw DomainException(LocaleContext.get().client_profile_domain_username);
    }

    return ProfileUserName._(profileUserName);
  }

  @override
  String toString() {
    return name;
  }
}
