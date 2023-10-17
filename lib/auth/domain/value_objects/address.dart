import 'package:beat_ecoprove/auth/domain/value_objects/postal_code.dart';

class Address {
  final String street;
  final int port;
  final String locality;
  final PostalCode postalCode;

  Address._(
      {required this.street,
      required this.port,
      required this.locality,
      required this.postalCode});

  factory Address.create(
      String street, int port, String locality, PostalCode postalCode) {
    return Address._(
        street: street, port: port, locality: locality, postalCode: postalCode);
  }

  @override
  String toString() {
    return "$street nº ${port.toString()} $locality $postalCode";
  }
}
