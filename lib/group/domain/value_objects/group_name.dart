import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';

class GroupName {
  final String name;

  GroupName._(this.name);

  factory GroupName.create(String groupName) {
    if (groupName.isEmpty) {
      throw DomainException("Por favor introduza um nome ao grupo");
    }

    return GroupName._(groupName);
  }

  @override
  String toString() {
    return name;
  }
}
