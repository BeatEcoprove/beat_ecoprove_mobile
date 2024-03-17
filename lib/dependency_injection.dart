import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/auth/domain/use-cases/login_use_case.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view.dart';
import 'package:beat_ecoprove/auth/presentation/login/login_view_model.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/auth/dependency_injection.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  static GetIt get locator => DependencyInjection._locator;

  void defaultServices() {
    var authProvider = locator.registerSingleton(AuthenticationProvider());
    locator.registerFactory(() => HttpClient());

    var httpClient = locator<HttpClient>();

    var authService = locator.registerSingleton(
      AuthenticationService(httpClient),
    );

    locator.registerFactory(() => HttpAuthClient(
          httpClient,
          authProvider,
          authService,
        ));

    registerDefaultPage(authProvider, authService);
  }

  void registerDefaultPage(
      AuthenticationProvider authProvider, AuthenticationService authService) {
    locator.registerSingleton(LoginUseCase(
      authProvider,
      authService,
    ));

    locator.registerFactory(() => LoginViewModel(
          locator<LoginUseCase>(),
          locator<INavigationManager>(),
          authService,
        ));

    locator.registerFactory(
      () => LoginView(
        viewModel: locator<LoginViewModel>(),
      ),
    );
  }

  ApplicationRouter setupDIContainer() {
    var applicationRouter = locator.registerSingleton(ApplicationRouter());
    locator.registerFactory<INavigationManager>(
      () => applicationRouter.navigationManager,
    );

    defaultServices();
    // var ws = locator.registerSingleton<IWebSocketManager>(SingleSessionManager(
    //   ServerConfig.websocketUrl,
    // ));

    // var levelUpdater = locator.registerSingleton(LevelUpProvider());
    // var notification = locator.registerSingleton(NotificationProvider());
    // var notificationManager = locator.registerSingleton(NotificationManager());
    // var groupManager = locator.registerSingleton(GroupManager());

    // locator.registerFactory(() => HttpClient());

    // locator.registerFactory(() => GroupService(locator<HttpAuthClient>()));
    // locator.registerSingleton<IWCNotifier>(SingleConnectionWsNotifier(
    //   ws,
    //   authProvider,
    //   levelUpdater,
    //   notification,
    //   notificationManager,
    //   groupManager,
    //   locator<GroupService>(),
    // ));

    // authProvider.checkAuth();
    // var router = locator.registerSingleton(AppRouter());

    addAuth(applicationRouter);

    // router.addRoutes(
    //   [
    //     authRoutes,
    //     clothingRoutes,
    //     registerClothRoutes,
    //     groupRoutes,
    //     profileRoutes,
    //     serviceProviderProfileRoutes,
    //     storeRoutes,
    //     orderRoutes,
    //     GoRoute(
    //       path: '/show_completed',
    //       builder: (context, state) =>
    //           ShowCompletedView(params: state.extra as ShowCompletedViewParams),
    //     ),
    //     GoRoute(
    //       path: '/make_profile_action',
    //       builder: (context, state) => MakeProfileActionView(
    //         params: state.extra as MakeProfileActionViewParams,
    //       ),
    //     ),
    //     GoRoute(
    //       path: '/list_details',
    //       builder: (context, state) => ListDetailsView(
    //         params: state.extra as ListDetailsViewParams,
    //       ),
    //     ),
    //     GoRoute(
    //       path: '/select_service',
    //       builder: (context, state) => SelectServiceView(
    //         services: state.extra as ServiceParams,
    //       ),
    //     ),
    //   ],
    // ).build();

    // locator.registerFactory(() => ListDetailsViewModel());
    // addProfile();
    // addServiceProviderProfile();
    // addCloset();
    // addHome();
    // addCloth();
    // addGroup();
    // addStore();
    // addOrders();

    return applicationRouter;
  }
}
