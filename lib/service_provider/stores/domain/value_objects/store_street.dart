import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class StoreStreet {
  final String name;

  StoreStreet._(this.name);

  factory StoreStreet.create(String storeStreet) {
    if (storeStreet.isEmpty) {
      throw DomainException(LocaleContext.get().service_provider_stores_street);
    }

    return StoreStreet._(storeStreet);
  }

  @override
  String toString() {
    return name;
  }
}
