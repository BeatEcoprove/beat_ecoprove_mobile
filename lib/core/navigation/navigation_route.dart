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
  RouteBase build(AppRoute? parentRoute) {
    route.parent = parentRoute;

    return GoRoute(
      parentNavigatorKey: parentRoute?.key ?? AppRoute.root.key,
      path: route.path,
      builder: view ?? (context, state) => const Text("Not Found"),
      routes: getRoutes(),
    );
  }
}
