import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/application_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationRoute<TView> extends ApplicationNavigation {
  final Widget Function(BuildContext context, GoRouterState state)? view;

  NavigationRoute({
    required super.route,
    this.view,
    super.routes,
  });

  @override
  GoRoute build(AppRoute? parentRoute) {
    route.parent = parentRoute;

    return GoRoute(
      path: route.path,
      builder: view != null
          ? (context, state) => view!(context, state)
          : (context, state) => const Text("Not Found"),
      routes: getRoutes(),
    );
  }
}
