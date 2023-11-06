import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_enterprise_use_case.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_personal_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/avatar_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/final_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_address_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/personal/personal_view_model.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';

extension AuthDependencyInjection on DependencyInjection {
  void _addUseCases(GetIt locator) {
    var authenticationService = locator<AuthenticationService>();
    var authenticationProvider = locator<AuthenticationProvider>();

    locator.registerSingleton(
        LoginUseCase(authenticationProvider, authenticationService));

    locator.registerSingleton(
        SignInEnterpriseUseCase(authenticationProvider, authenticationService));

    locator.registerSingleton(
        SignInPersonalUseCase(authenticationProvider, authenticationService));
  }

  void _addViewModels(GetIt locator) {
    var singInPersonalUseCase = locator<SignInPersonalUseCase>();
    var singInEnterpriseUseCase = locator<SignInEnterpriseUseCase>();
    var authService = locator<AuthenticationService>();
    var router = locator<AppRouter>();

    locator.registerFactory(
        () => LoginViewModel(locator<LoginUseCase>(), router.appRouter));
    locator.registerFactory(() => SignInViewModel(
        router.appRouter, singInPersonalUseCase, singInEnterpriseUseCase));

    locator.registerFactory(() => SelectUserViewModel());
    locator.registerFactory(() => PersonalViewModel());
    locator.registerFactory(() => AvatarStageViewModel(authService));
    locator.registerFactory(() => FinalStageViewModel(authService));
    locator.registerFactory(() => EnterpriseStageViewModel());
    locator.registerFactory(() => EnterpriseAddressStageViewModel());
  }

  void addAuth() {
    GetIt locator = DependencyInjection.locator;

    var httpClient = locator<HttpClient>();
    var authProvider = locator<AuthenticationProvider>();

    var authService =
        locator.registerSingleton(AuthenticationService(httpClient));

    locator.registerFactory(
        () => HttpAuthClient(locator<HttpClient>(), authProvider, authService));

    _addUseCases(locator);
    _addViewModels(locator);
  }
}
