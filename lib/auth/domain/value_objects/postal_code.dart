import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class PostalCode {
  final String value;
  static final RegExp regex = RegExp(r'\d{4}-\d{3}$');

  PostalCode._({required this.value});

  factory PostalCode.create(String postalCode) {
    if (!regex.hasMatch(postalCode)) {
      throw DomainException("O código postal deve ter 7 números");
    }

    return PostalCode._(value: postalCode);
  }

  @override
  String toString() {
    return value;
  }
}
