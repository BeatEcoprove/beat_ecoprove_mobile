import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class Name {
  final String firstName;
  final String lastName;

  Name._({required this.firstName, required this.lastName});

  factory Name.create(String firstName, String lastName) {
    if (firstName.isEmpty) {
      throw DomainException("Por favor introduza o seu primeiro nome");
    }

    if (lastName.isEmpty) {
      throw DomainException("Por favor introduza o seu último nome");
    }

    if (firstName.contains(" ") && lastName.contains(" ")) {
      throw DomainException(
          "Por favor introduza apenas o seu primeiro e último nome");
    }

    return Name._(firstName: firstName, lastName: lastName);
  }

  @override
  String toString() {
    return "$firstName $lastName";
  }
}
