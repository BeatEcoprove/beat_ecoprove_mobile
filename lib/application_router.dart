import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationRouter {
  final List<RouteBase> _routes = [];

  final NavigationManager _navigationManager = NavigationManager(GoRouter(
    routes: [],
  ));

  final GoRoute _defaultRoute = GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return IView.of<LoginView>();
    },
  );

  ApplicationRouter() {
    _routes.add(_defaultRoute);
  }

  NavigationManager get navigationManager => _navigationManager;

  ApplicationRouter addRoute(RouteBase route) {
    _routes.add(route);

    return this;
  }

  ApplicationRouter addRoutes(List<RouteBase> routes) {
    _routes.addAll(routes);

    return this;
  }

  void build() {
    _navigationManager.setRouter(GoRouter(
      routes: _routes,
    ));
  }
}
