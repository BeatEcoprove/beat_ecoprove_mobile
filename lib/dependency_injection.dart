import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:beat_ecoprove/core/presentation/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/presentation/select_service_view.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/group_ws_notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/websocket_notifier.dart';
import 'package:beat_ecoprove/group/dependency_injection.dart';
import 'package:beat_ecoprove/group/routes.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
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

    var ws = locator.registerSingleton<IWebSocketManager>(SingleSessionManager(
      ServerConfig.websocketUrl,
    ));

    var levelUpdater = locator.registerSingleton(LevelUpProvider());
    var notification = locator.registerSingleton(NotificationProvider());
    var notificationManager = locator.registerSingleton(NotificationManager());
    var groupManager = locator.registerSingleton(GroupManager());

    locator.registerSingleton<IWCNotifier>(SingleConnectionWsNotifier(
      ws,
      authProvider,
      levelUpdater,
      notification,
      notificationManager,
      // locator<GroupService>(),
      groupManager,
    ));

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
        path: '/list_details',
        builder: (context, state) => ListDetailsView(
          params: state.extra as ListDetailsViewParams,
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

    locator.registerFactory(() => ListDetailsViewModel());
    addProfile();
    addCloset();
    addHome();
    addCloth();
    addGroup();

    locator.registerSingleton(GroupWSNotifier(
      ws,
      authProvider,
      levelUpdater,
      notification,
      notificationManager,
      locator<GroupService>(),
      groupManager,
    ));
  }
}
