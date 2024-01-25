import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/presentation/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/presentation/select_service_view.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/group/dependency_injection.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:beat_ecoprove/profile/dependency_injection.dart';
import 'package:beat_ecoprove/profile/routes.dart';
import 'package:beat_ecoprove/register_cloth/dependency_injection.dart';
import 'package:beat_ecoprove/auth/dependency_injection.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/clothing/dependency_injection.dart';
import 'package:beat_ecoprove/clothing/routes.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/home/dependency_injection.dart';
import 'package:beat_ecoprove/register_cloth/routes.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => DependencyInjection._locator;

  void setupDIContainer() {
    var authProvider = locator.registerSingleton(AuthenticationProvider());
    locator.registerSingleton(NotificationProvider());

    authProvider.checkAuth();

    locator.registerSingleton(AppRouter([
      authRoutes,
      clothingRoutes,
      registerClothRoutes,
      groupRoutes,
      profileRoutes,
      GoRoute(
        path: '/show_completed',
        builder: (context, state) =>
            ShowCompletedView(params: state.extra as ShowCompletedViewParams),
      ),
      GoRoute(
        path: '/make_profile_action',
        builder: (context, state) => MakeProfileActionView(
          params: state.extra as MakeProfileActionViewParams,
        ),
      ),
      GoRoute(
        path: '/select_service',
        builder: (context, state) => SelectServiceView(
          services: state.extra as ServiceParams,
        ),
      ),
    ]));

    locator.registerFactory(() => HttpClient());

    addAuth();
    addCloset();
    addHome();
    addCloth();
    addGroup();
    addProfile();
  }
}
