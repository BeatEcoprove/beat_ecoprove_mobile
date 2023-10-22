import 'package:beat_ecoprove/auth/dependency_injection.dart';
import 'package:beat_ecoprove/core/providers/authentication_provider.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => DependencyInjection._locator;

  void setupDIContainer() {
    locator.registerSingleton(AuthenticationProvider());

    addAuth();
  }
}
