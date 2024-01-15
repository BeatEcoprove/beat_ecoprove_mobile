import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/auth/presentation/select_user/select_user_view.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/common/complete_sign_in_view.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_type.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute authRoutes = GoRoute(
    name: 'home',
    path: '/',
    builder: (BuildContext context, GoRouterState state) => const LoginView(),
    routes: [
      GoRoute(
        path: 'select-user',
        builder: (context, state) => const SelectUserView(),
      ),
      GoRoute(
        path: 'sign_in/:userType',
        builder: (context, state) {
          return SignInView(
            userType: SignUserType.getTypeOf(state.pathParameters['userType']),
          );
        },
      ),
    ]);
