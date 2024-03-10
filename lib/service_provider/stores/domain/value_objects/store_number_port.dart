import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class StoreNumberPort {
  final String number;

  StoreNumberPort._(this.number);

  factory StoreNumberPort.create(String storeNumberPort) {
    if (storeNumberPort.isEmpty) {
      throw DomainException("Por favor introduza o número da porta!");
    }

    try {
      int.parse(storeNumberPort);
    } catch (e) {
      throw DomainException("O número da porta deve ser um número!");
    }

    return StoreNumberPort._(storeNumberPort);
  }

  @override
  String toString() {
    return number;
  }
}
