import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class ProfileName {
  final String name;

  ProfileName._(this.name);

  factory ProfileName.create(String profileName) {
    if (profileName.isEmpty) {
      throw DomainException(
          LocaleContext.get().client_profile_domain_profile_name);
    }

    return ProfileName._(profileName);
  }

  @override
  String toString() {
    return name;
  }
}
