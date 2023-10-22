import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/core/providers/authentication_provider.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/default_layout/presentation/default_layout_view.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final List<RouteBase> routes;
  late GoRouter _appRouter;

  AppRouter(this.routes) {
    _appRouter = GoRouter(routes: _setupRoutes());
  }

  final GoRoute _defaultRoute = GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) =>
        checkAuthorization(),
  );

  static Widget checkAuthorization() =>
      DependencyInjection.locator<AuthenticationProvider>().isAuthenticated
          ? const DefaultLayoutView(
              header: StandardHeader(sustainablePoints: 100),
            )
          : const LoginView();

  List<RouteBase> _setupRoutes() {
    return [_defaultRoute, ...routes];
  }

  GoRouter get appRouter => _appRouter;
}
