import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/closet/clothing_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';
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
        checkAuthorization(context),
  );

  static Widget checkAuthorization(BuildContext context) {
    var authProvider = DependencyInjection.locator<AuthenticationProvider>();
    var notificationProvider =
        DependencyInjection.locator<NotificationProvider>();
    notificationProvider.setContext(context);
    var leverUpProvider = DependencyInjection.locator<LevelUpProvider>();
    leverUpProvider.setContext(context);

    if (!authProvider.isAuthenticated) {
      return const LoginView();
    }

    Future.sync(() => DependencyInjection.locator<StaticValuesProvider>()
        .fetchStaticValues());

    // Client Version
    // return const Swiper(
    //   views: [HomeView(), ClothingView(), GroupView(), ProfileView()],
    //   bottomNavigationBarOptions: [
    //     Icon(Icons.home_rounded),
    //     SvgImage(path: "assets/shirt.svg"),
    //     Icon(Icons.public_rounded),
    //     Icon(Icons.person),
    //   ],
    // );

    // Service Provider Version
    return const Swiper(
      hasRegisterCloth: false,
      views: [
        HomeView(),
        OrdersView(),
        StoreView(),
        GroupView(),
        ServiceProviderProfileView()
      ],
      bottomNavigationBarOptions: [
        Icon(Icons.home_rounded),
        SvgImage(path: "assets/shirt.svg"),
        Icon(Icons.store_mall_directory),
        Icon(Icons.public_rounded),
        Icon(Icons.person),
      ],
    );
  }

  List<RouteBase> _setupRoutes() {
    return [_defaultRoute, ...routes];
  }

  GoRouter get appRouter => _appRouter;
}
