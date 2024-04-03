import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/application_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationGuard extends ApplicationNavigation {
  final Widget Function(BuildContext context, GoRouterState state)? view;
  final AppRoute? Function(BuildContext context, GoRouterState state)
      redirectPages;

  NavigationGuard({
    required super.routes,
    required super.route,
    required this.redirectPages,
    this.view,
  });

  @override
  GoRoute build(AppRoute? parentRoute) {
    route.parent = parentRoute;

    return GoRoute(
      path: route.path,
      builder: view != null
          ? (context, state) => view!(context, state)
          : (context, state) => const Text("Not Found!"),
      redirect: (context, state) {
        return redirectPages(context, state)?.navigationPath;
      },
      routes: getRoutes(),
    );
  }
}
