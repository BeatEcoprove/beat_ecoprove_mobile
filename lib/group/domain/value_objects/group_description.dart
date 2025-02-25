import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class GroupDescription {
  final String description;

  GroupDescription._(this.description);

  factory GroupDescription.create(String groupDescription) {
    if (groupDescription.isEmpty) {
      throw DomainException(LocaleContext.get().group_domain_group_description);
    }

    return GroupDescription._(groupDescription);
  }

  @override
  String toString() {
    return description;
  }
}
