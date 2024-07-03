import 'package:beat_ecoprove/core/domain/entities/employee.dart';

class Worker {
  final String id;
  final String name;
  final String email;
  final EmployeeType type;

  Worker({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });
}
