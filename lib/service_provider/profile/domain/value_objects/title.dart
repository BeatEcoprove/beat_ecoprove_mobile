import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class TitleInput {
  final String title;

  TitleInput._(this.title);

  factory TitleInput.create(String title) {
    if (title.isEmpty) {
      throw DomainException(
          LocaleContext.get().service_provider_profile_add_title);
    }

    return TitleInput._(title);
  }

  @override
  String toString() {
    return title;
  }
}
