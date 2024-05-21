import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class StoreStreet {
  final String name;

  StoreStreet._(this.name);

  factory StoreStreet.create(String storeStreet) {
    if (storeStreet.isEmpty) {
      throw DomainException("Por favor introduza a rua da loja!");
    }

    return StoreStreet._(storeStreet);
  }

  @override
  String toString() {
    return name;
  }
}
