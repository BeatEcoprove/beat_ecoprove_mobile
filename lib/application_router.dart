import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationRouter<TView extends IView> {
  final List<RouteBase> _routes = [];

  final NavigationManager _navigationManager = NavigationManager(GoRouter(
    routes: [],
  ));

  // final GoRoute _defaultRoute = GoRoute(
  //   path: '/',
  //   builder: (BuildContext context, GoRouterState state) {
  //     return IView.of(view: startingView);
  //   },
  // );

  GoRoute getDefaultRoute<TClass extends IView>() {
    return GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return IView.of<TClass>();
      },
    );
  }

  ApplicationRouter() {
    _routes.add(getDefaultRoute<TView>());
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
