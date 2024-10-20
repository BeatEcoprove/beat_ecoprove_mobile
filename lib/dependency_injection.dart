import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/auth/dependency_injection.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/client/dependency_injection.dart';
import 'package:beat_ecoprove/core/config/server_config.dart';
import 'package:beat_ecoprove/core/dependency_injection.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/groups/group_manager.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/single_ws_notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/websocket_notifier.dart';
import 'package:beat_ecoprove/core/services/country_codes_service.dart';
import 'package:beat_ecoprove/core/services/geo_api_service.dart';
import 'package:beat_ecoprove/core/services/internet_service.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/group/dependency_injection.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';
import 'package:beat_ecoprove/home/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/dependency_injection.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => DependencyInjection._locator;

  ApplicationRouter createApplicationRouter<TView extends LinearView>() {
    var applicationRouter = locator.registerSingleton(
      ApplicationRouter<TView>(),
    );

    locator.registerFactory<INavigationManager>(
      () => applicationRouter.navigationManager,
    );

    var authProvider = locator.registerSingleton(AuthenticationProvider());
    locator.registerFactory(() => HttpClient());

    var httpClient = locator<HttpClient>();
    locator.registerFactory(() => CountryCodesService());
    locator.registerFactory(() => GeoApiService());

    var authService = locator.registerSingleton(
      AuthenticationService(httpClient),
    );

    locator.registerFactory(
      () => HttpAuthClient(
        httpClient,
        authProvider,
        authService,
      ),
    );

    return applicationRouter;
  }

  void registerProviders(GetIt locator) {
    locator.registerSingleton<INotificationProvider>(NotificationProvider());
    locator.registerSingleton(LevelUpProvider());
    locator.registerSingleton(NotificationManager());
    locator.registerSingleton(GroupManager());
    locator.registerSingleton<InternetService>(
      InternetServiceImpl(
        locator<AuthenticationService>(),
      ),
    );
  }

  void registerWebsockets(GetIt locator) {
    var ws = locator.registerSingleton<IWebSocketManager>(
      SingleSessionManager(
        ServerConfig.websocketUrl,
      ),
    );

    locator.registerFactory(
      () => GroupService(locator<HttpAuthClient>()),
    );

    locator.registerSingleton<IWCNotifier>(SingleConnectionWsNotifier(
      ws,
      locator<AuthenticationProvider>(),
      locator<LevelUpProvider>(),
      locator<INotificationProvider>(),
      locator<NotificationManager>(),
      locator<GroupManager>(),
      locator<GroupService>(),
    ));
  }

  ApplicationRouter setupDIContainer() {
    var applicationRouter = createApplicationRouter<LoginView>();

    registerProviders(locator);
    registerWebsockets(locator);

    addAuth(applicationRouter);
    addClient(applicationRouter);
    addGroup(applicationRouter);
    addHome(applicationRouter);
    addServiceProvider(applicationRouter);
    addCore(applicationRouter);

    return applicationRouter;
  }
}
