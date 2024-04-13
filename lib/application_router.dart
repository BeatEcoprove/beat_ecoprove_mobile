import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/application_navigation.dart';
import 'package:beat_ecoprove/core/navigation/navigation_guard.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/routes.dart';
import 'package:go_router/go_router.dart';

class ApplicationRouter<TView extends LinearView> {
  final ApplicationNavigation router = NavigationGuard(
    route: AppRoute.root,
    view: (context, state) => LinearView.of<TView>(),
    routes: [],
    redirectPages: (context, state) {
      var authProvider = DependencyInjection.locator<AuthenticationProvider>();

      if (!authProvider.isAuthenticated) {
        if (state.fullPath != AuthRoutes.login.navigationPath) {
          return null;
        }

        return AuthRoutes.login;
      }

      if (state.fullPath == AppRoute.root.navigationPath) {
        return HomeRoutes.home;
      }

      return null;
    },
  );

  final NavigationManager _navigationManager = NavigationManager(GoRouter(
    routes: [],
  ));

  NavigationManager get navigationManager => _navigationManager;

  ApplicationRouter addRoute(ApplicationNavigation route) {
    router.routes.add(route);

    return this;
  }

  ApplicationRouter addRoutes(List<ApplicationNavigation> routes) {
    router.routes.addAll(routes);

    return this;
  }

  void build() {
    _navigationManager.setRouter(
      GoRouter(
        debugLogDiagnostics: true,
        navigatorKey: AppRoute.root.key,
        routes: [
          router.build(null),
        ],
      ),
    );
  }
}
