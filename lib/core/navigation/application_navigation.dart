import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:go_router/go_router.dart';

abstract class ApplicationNavigation {
  final AppRoute route;
  final List<ApplicationNavigation> routes;

  ApplicationNavigation({
    required this.route,
    this.routes = const [],
  });

  RouteBase build(AppRoute? parentRoute);

  List<RouteBase> getRoutes() {
    return routes.map((route) {
      return route.build(this.route);
    }).toList();
  }
}
