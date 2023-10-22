import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class UserName {
  final String value;

  UserName._(this.value);

  factory UserName.create(String userName) {
    if (userName.isEmpty) {
      throw DomainException("Porfavor introduza um nome de utilizador");
    }

    return UserName._(userName);
  }

  @override
  String toString() {
    return value;
  }
}
