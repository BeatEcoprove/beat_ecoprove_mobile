import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class DescriptionInput {
  final String title;

  DescriptionInput._(this.title);

  factory DescriptionInput.create(String title) {
    if (title.isEmpty) {
      throw DomainException("Por favor introduza uma descrição");
    }

    return DescriptionInput._(title);
  }

  @override
  String toString() {
    return title;
  }
}
