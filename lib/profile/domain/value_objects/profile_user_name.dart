import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class ProfileUserName {
  final String name;

  ProfileUserName._(this.name);

  factory ProfileUserName.create(String profileUserName) {
    if (profileUserName.isEmpty) {
      throw DomainException(
          "Por favor introduza um nome de exibição ao perfil");
    }

    return ProfileUserName._(profileUserName);
  }

  @override
  String toString() {
    return name;
  }
}
