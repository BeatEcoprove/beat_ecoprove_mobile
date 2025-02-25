import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class ClothName {
  final String name;

  ClothName._(this.name);

  factory ClothName.create(String clothName) {
    if (clothName.isEmpty) {
      throw DomainException(
          LocaleContext.get().client_register_cloth_domain_name);
    }

    return ClothName._(clothName);
  }

  @override
  String toString() {
    return name;
  }
}
