import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension AuthDependencyInjection on DependencyInjection {
  void addAuth() {
    GetIt locator = DependencyInjection.locator;
    AuthenticationService authenticationService = AuthenticationService();

    locator.registerFactory(() => authenticationService);
    locator.registerFactory(() => LoginUseCase(authenticationService));
  }
}
