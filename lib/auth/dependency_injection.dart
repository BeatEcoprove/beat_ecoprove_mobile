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
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension AuthDependencyInjection on DependencyInjection {
  void _addUseCases() {
    GetIt locator = DependencyInjection.locator;

    locator.registerSingleton(LoginUseCase(locator<AuthenticationService>()));
    locator.registerSingleton(SignInEnterpriseUseCase());
    locator.registerSingleton(SignInPersonalUseCase());
  }

  void _addViewModels() {
    GetIt locator = DependencyInjection.locator;

    locator.registerFactory(() => LoginViewModel(locator<LoginUseCase>()));
    locator.registerFactory(() => SignInViewModel(
        locator<SignInPersonalUseCase>(), locator<SignInEnterpriseUseCase>()));
    locator.registerFactory(() => SelectUserViewModel());
    locator.registerFactory(() => PersonalViewModel());
    locator.registerFactory(() => AvatarStageViewModel());
    locator.registerFactory(() => FinalStageViewModel());
    locator.registerFactory(() => EnterpriseStageViewModel());
    locator.registerFactory(() => EnterpriseAddressStageViewModel());
  }

  void addAuth() {
    GetIt locator = DependencyInjection.locator;

    locator.registerSingleton(AuthenticationService());

    _addUseCases();
    _addViewModels();
  }
}
