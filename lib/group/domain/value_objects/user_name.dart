import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class UserNameInvite {
  final String name;

  UserNameInvite._(this.name);

  factory UserNameInvite.create(String userNameInvite) {
    if (userNameInvite.isEmpty) {
      throw DomainException("Por favor introduza um nome de utilizador!");
    }

    return UserNameInvite._(userNameInvite);
  }

  @override
  String toString() {
    return name;
  }
}
