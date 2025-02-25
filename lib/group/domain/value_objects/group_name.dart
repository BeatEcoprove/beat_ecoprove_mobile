import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class GroupName {
  final String name;

  GroupName._(this.name);

  factory GroupName.create(String groupName) {
    if (groupName.isEmpty) {
      throw DomainException(LocaleContext.get().group_domain_group_name);
    }

    return GroupName._(groupName);
  }

  @override
  String toString() {
    return name;
  }
}
