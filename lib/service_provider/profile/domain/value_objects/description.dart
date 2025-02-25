import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class DescriptionInput {
  final String title;

  DescriptionInput._(this.title);

  factory DescriptionInput.create(String title) {
    if (title.isEmpty) {
      throw DomainException(
          LocaleContext.get().service_provider_profile_add_description);
    }

    return DescriptionInput._(title);
  }

  @override
  String toString() {
    return title;
  }
}
