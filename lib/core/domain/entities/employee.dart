import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';

class Employee extends User {
  final EmployeeType workerType;
  final String storeId;

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
    required super.phoneNumber,
    required this.workerType,
    required this.storeId,
  });
}

enum EmployeeType implements Comparable<EmployeeType> {
  worker(value: "worker"),
  manager(value: "manager");

  final String value;

  const EmployeeType({required this.value});

  String get text {
    final locale = LocaleContext.get();
    return switch (this) {
      EmployeeType.worker => locale.core_domain_employee_worker,
      EmployeeType.manager => locale.core_domain_employee_manager,
    };
  }

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
