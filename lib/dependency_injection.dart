import 'package:beat_ecoprove/auth/dependency_injection.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  final locator = GetIt.instance;

  void setupDIContainer() {
    addAuth();
  }
}
