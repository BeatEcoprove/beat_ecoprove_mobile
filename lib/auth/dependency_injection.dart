import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension AuthDependencyInjection on DependencyInjection {
  void addAuth() {
    GetIt locator = DependencyInjection.locator;
    AuthenticationService authenticationService = AuthenticationService();
    LoginUseCase loginUseCase = LoginUseCase(authenticationService);

    // Add Login
    locator.registerFactory(() => authenticationService);
    locator.registerFactory(() => loginUseCase);
    locator.registerFactory(() => LoginViewModel(loginUseCase));

    // Add Select User
    locator.registerFactory(() => SelectUserViewModel());

    // Add Sign In
    locator.registerFactory(() => SignInViewModel());
  }
}
