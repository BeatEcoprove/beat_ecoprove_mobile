import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_enterprise_use_case.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/sign_in_personal_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_params.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension AuthDependencyInjection on DependencyInjection {
  void _addUseCases(GetIt locator) {
    var authenticationService = locator<AuthenticationService>();
    var authenticationProvider = locator<AuthenticationProvider>();

    locator.registerSingleton(
      LoginUseCase(
        authenticationProvider,
        authenticationService,
      ),
    );

    locator.registerSingleton(
      SignInEnterpriseUseCase(
        authenticationProvider,
        authenticationService,
      ),
    );

    locator.registerSingleton(
      SignInPersonalUseCase(
        authenticationProvider,
        authenticationService,
      ),
    );
  }

  void _addViewModels(GetIt locator) {
    var singInPersonalUseCase = locator<SignInPersonalUseCase>();
    var singInEnterpriseUseCase = locator<SignInEnterpriseUseCase>();
    var authService = locator<AuthenticationService>();

    locator.registerFactory(
      () => LoginViewModel(
        locator<LoginUseCase>(),
        locator<INavigationManager>(),
        authService,
        locator<INotificationProvider>(),
      ),
    );

    locator.registerFactory(
      () => SignInViewModel(
        locator<INavigationManager>(),
        singInPersonalUseCase,
        singInEnterpriseUseCase,
        locator<INotificationProvider>(),
      ),
    );

    locator.registerFactory(
      () => InsertResetCodeViewModel(
        locator<INavigationManager>(),
      ),
    );

    locator.registerFactory(
      () => ResetPasswordViewModel(
        locator<INavigationManager>(),
        authService,
      ),
    );

    locator.registerFactory(
      () => SelectUserViewModel(
        locator<INavigationManager>(),
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactory(
      () => LoginView(
        viewModel: locator<LoginViewModel>(),
      ),
    );

    locator.registerFactory(
      () => InsertResetCodeView(
        viewModel: locator<InsertResetCodeViewModel>(),
      ),
    );

    locator.registerFactoryParam<SignInView, SignInViewParams, void>(
      (args, _) => SignInView(
        viewModel: locator<SignInViewModel>(),
        args: args,
      ),
    );

    locator.registerFactoryParam<ResetPasswordView, ResetPasswordParams, void>(
      (args, _) => ResetPasswordView(
        viewModel: locator<ResetPasswordViewModel>(),
        args: args,
      ),
    );

    locator.registerFactory(
      () => SelectUserView(
        viewModel: locator<SelectUserViewModel>(),
      ),
    );
  }

  void addAuth(ApplicationRouter app) {
    GetIt locator = DependencyInjection.locator;

    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);

    app.addRoute(authRoute);
  }
}
