import 'package:beat_ecoprove/core/domain/entities/user.dart';

class Employee extends User {
  final EmployeeType workerType;

  Employee({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.level,
    required super.levelPercent,
    required super.sustainablePoints,
    required super.ecoScore,
    required super.ecoCoins,
    required super.xp,
    required super.nextLevelXp,
    super.type = UserType.employee,
    required this.workerType,
  });
}

enum EmployeeType implements Comparable<EmployeeType> {
  worker(value: "worker", text: "Funcionário"),
  manager(value: "manager", text: "Gerente");

  final String value;
  final String text;

  const EmployeeType({required this.value, required this.text});

  static List<EmployeeType> getAllTypes() {
    return EmployeeType.values.toList();
  }

  static EmployeeType getOf(String value) =>
      EmployeeType.values.singleWhere((element) => element.value == value);

  static String getValue(String text) =>
      EmployeeType.values.singleWhere((element) => element.text == text).value;

  @override
  int compareTo(EmployeeType other) {
    throw UnimplementedError();
  }
}
