import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_params.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/presentation/no_wifi/no_wifi_view.dart';
import 'package:beat_ecoprove/core/view.dart';

extension AuthRoutes on AppRoute {
  static final AppRoute auth = AppRoute(path: "auth");

  static final AppRoute login = AppRoute(
    path: "login",
  );

  static final AppRoute selectUser = AppRoute(
    path: "select-user",
  );

  static final AppRoute signIn = AppRoute(
    path: "sign_in/:userType",
  );

  static AppRoute setSignIn(String userType) {
    return AppRoute.withParent(auth, "sign_in/$userType");
  }

  static final AppRoute resetCode = AppRoute(
    path: "insert_reset_code",
  );

  static final AppRoute resetPassword = AppRoute(
    path: "reset_password",
  );

  static final AppRoute noWifi = AppRoute(
    path: "no_wifi",
  );
}

final NavigationRoute authRoute = NavigationRoute(
  route: AuthRoutes.auth,
  routes: [
    NavigationRoute(
      route: AuthRoutes.login,
      view: (context, state) => LinearView.of<LoginView>(),
    ),
    NavigationRoute(
      route: AuthRoutes.selectUser,
      view: (context, state) => LinearView.of<SelectUserView>(),
    ),
    NavigationRoute(
      route: AuthRoutes.signIn,
      view: (context, state) => ArgumentView.of<SignInView>(
        SignInViewParams(
          SignUseroptions.getTypeOf(state.pathParameters['userType']),
        ),
      ),
    ),
    NavigationRoute(
      route: AuthRoutes.resetCode,
      view: (context, state) => LinearView.of<InsertResetCodeView>(),
    ),
    NavigationRoute(
      route: AuthRoutes.resetPassword,
      view: (context, state) => ArgumentView.of<ResetPasswordView>(
        state.extra as ResetPasswordParams,
      ),
    ),
    NavigationRoute(
      route: AuthRoutes.noWifi,
      view: (context, state) => LinearView.of<NoWifiView>(),
    ),
  ],
);
