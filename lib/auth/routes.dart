import 'package:beat_ecoprove/auth/presentation/forgot_password/insert_reset_code/insert_reset_code_view.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_params.dart';
import 'package:beat_ecoprove/auth/presentation/forgot_password/reset_password/reset_password_view.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRoute authRoutes = GoRoute(
  name: 'home',
  path: '/',
  builder: (BuildContext context, GoRouterState state) {
    return IView.of<LoginView>();
  },
  routes: [
    GoRoute(
      path: 'select-user',
      builder: (context, state) {
        return IView.of<SelectUserView>();
      },
    ),
    GoRoute(
      path: 'sign_in/:userType',
      builder: (context, state) {
        return ArgumentedView.of<SignInView>(
          SignInViewParams(
            SignUseroptions.getTypeOf(state.pathParameters['userType']),
          ),
        );
      },
    ),
    GoRoute(
      path: 'insert_reset_code',
      builder: (context, state) => IView.of<InsertResetCodeView>(),
    ),
    GoRoute(
      path: 'reset_password',
      builder: (context, state) => ArgumentedView.of<ResetPasswordView>(
        state.extra as ResetPasswordParams,
      ),
    ),
  ],
);
