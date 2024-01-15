import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class ProfileName {
  final String name;

  ProfileName._(this.name);

  factory ProfileName.create(String profileName) {
    if (profileName.isEmpty) {
      throw DomainException("Por favor introduza um nome ao perfil");
    }

    return ProfileName._(profileName);
  }

  @override
  String toString() {
    return name;
  }
}
