import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class StoreNumberPort {
  final String number;
  static final RegExp regex = RegExp(r'^\d{1,8}$');

  StoreNumberPort._(this.number);

  factory StoreNumberPort.create(String storeNumberPort) {
    if (!regex.hasMatch(storeNumberPort)) {
      throw DomainException("O número da porta deve ser um número!");
    }

    return StoreNumberPort._(storeNumberPort);
  }

  @override
  String toString() {
    return number;
  }
}
