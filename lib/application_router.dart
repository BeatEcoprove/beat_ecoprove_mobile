import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/application_navigation.dart';
import 'package:beat_ecoprove/core/navigation/navigation_guard.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/event_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/services/internet_service.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/routes.dart';
import 'package:beat_ecoprove/service_provider/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationRouter<TView extends LinearView> {
  static void loadContextEnviroment(BuildContext context) {
    var notificationProvider =
        DependencyInjection.locator<INotificationProvider>();
    notificationProvider.setContext(context);
    var leverUpProvider = DependencyInjection.locator<LevelUpProvider>();
    leverUpProvider.setContext(context);

    final eventProvider = DependencyInjection.locator<IEventProvider>();
    final navigationManager = DependencyInjection.locator<INavigationManager>();

    eventProvider.notifications.listen((event) {
      switch (event.runtimeType) {
        case ChangeWifiStatusEvent:
          if (!(event as ChangeWifiStatusEvent).wifiOn) {
            navigationManager.push(AuthRoutes.noWifi);
          }
          navigationManager.push(AuthRoutes.login);

        default:
          Exception("Event failure!");
      }
    });
  }

  final ApplicationNavigation router = NavigationGuard(
    route: AppRoute.root,
    view: (context, state) {
      LocaleContext.setContext(context);
      loadContextEnviroment(context);

      return LinearView.of<TView>();
    },
    routes: [],
    redirectPages: (context, state) {
      var authProvider = DependencyInjection.locator<AuthenticationProvider>();
      var internetService = DependencyInjection.locator<InternetService>();

      if (!internetService.wifiOn) {
        return AuthRoutes.noWifi;
      }

      if (!authProvider.isAuthenticated) {
        if (state.fullPath != AuthRoutes.login.navigationPath) {
          return null;
        }

        return AuthRoutes.login;
      }

      bool checkCurrentPath(GoRouterState state) {
        return state.fullPath == AppRoute.root.navigationPath ||
            state.fullPath == AuthRoutes.login.navigationPath;
      }

      switch (authProvider.appUser!.type) {
        case UserType.consumer:
          if (checkCurrentPath(state)) {
            return HomeRoutes.home;
          }
          break;
        case UserType.organization:
        case UserType.employee:
          if (checkCurrentPath(state)) {
            return ServiceProviderRoutes.serviceProvider;
          }
          break;
        default:
          if (checkCurrentPath(state)) {
            return HomeRoutes.home;
          }
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
