import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class StoreNumberPort {
  final String number;
  static final RegExp regex = RegExp(r'^\d{1,8}$');

  StoreNumberPort._(this.number);

  factory StoreNumberPort.create(String storeNumberPort) {
    if (!regex.hasMatch(storeNumberPort)) {
      throw DomainException(LocaleContext.get()
          .service_provider_stores_port_number_must_be_number);
    }

    return StoreNumberPort._(storeNumberPort);
  }

  @override
  String toString() {
    return number;
  }
}
