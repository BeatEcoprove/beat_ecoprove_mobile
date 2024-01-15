import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class GroupDescription {
  final String description;

  GroupDescription._(this.description);

  factory GroupDescription.create(String groupDescription) {
    if (groupDescription.isEmpty) {
      throw DomainException("Por favor introduza uma descrição ao grupo");
    }

    return GroupDescription._(groupDescription);
  }

  @override
  String toString() {
    return description;
  }
}
