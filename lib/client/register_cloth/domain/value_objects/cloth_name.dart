import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class ClothName {
  final String name;

  ClothName._(this.name);

  factory ClothName.create(String clothName) {
    if (clothName.isEmpty) {
      throw DomainException("Por favor introduza um nome para a peça de roupa");
    }

    return ClothName._(clothName);
  }

  @override
  String toString() {
    return name;
  }
}
