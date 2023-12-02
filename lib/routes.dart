import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';
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

  static Widget checkAuthorization() {
    var authProvider = DependencyInjection.locator<AuthenticationProvider>();

    return authProvider.isAuthenticated
        ? const Swiper(
            views: [HomeView(), ClothingView()],
            bottomNavigationBarOptions: [
              Icon(Icons.home_rounded),
              SvgImage(path: "assets/shirt.svg"),
              Icon(Icons.public_rounded),
              Icon(Icons.person),
            ],
          )
        : const LoginView();
  }

  List<RouteBase> _setupRoutes() {
    return [_defaultRoute, ...routes];
  }

  GoRouter get appRouter => _appRouter;
}
