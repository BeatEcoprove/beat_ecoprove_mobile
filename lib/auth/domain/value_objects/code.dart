import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class Code {
  final int length = 6;
  final String value;

  Code._(this.value);

  factory Code.create(String code) {
    if (code.isEmpty) {
      throw DomainException("Introduza o código");
    }

    if (code.length != 6) {
      throw DomainException("O código deve ter 6 digitos");
    }

    return Code._(code);
  }

  @override
  String toString() {
    return value;
  }
}
