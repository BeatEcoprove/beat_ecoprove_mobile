import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service_proxy.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view_model.dart';
import 'package:beat_ecoprove/home/domain/use-cases/get_services_providers_use_case.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_model.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view_model.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton_service_provider/main_skeleton_service_provider_view.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton_service_provider/main_skeleton_service_provider_view_model.dart';
import 'package:beat_ecoprove/home/routes.dart';
import 'package:beat_ecoprove/home/services/service_provider_service.dart';
import 'package:get_it/get_it.dart';

extension HomeDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var closetService = locator<ClosetService>();
    var actionService = locator<ActionServiceProxy>();
    var getServicesProvidersUseCase = locator<GetServicesProvidersUseCase>();
    var router = locator<INavigationManager>();

    locator.registerFactory(
      () => ServiceViewModel(
        authProvider,
        locator<ServiceProviderService>(),
      ),
    );

    locator.registerFactory(
      () => HomeViewModel(
        authProvider,
        closetService,
        actionService,
        getServicesProvidersUseCase,
        router,
        locator<StaticValuesProvider>(),
        locator<ServiceProviderService>(),
      ),
    );

    locator.registerSingleton(
      MainSkeletonViewModel(
        locator<StaticValuesProvider>(),
      ),
    );

    locator.registerFactory(
      () => MainSkeletonServiceProviderViewModel(
        locator<StaticValuesProvider>(),
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactoryParam<ServiceView, ServiceProviderParams, void>(
      (params, _) => ServiceView(
        viewModel: locator<ServiceViewModel>(),
        args: params,
      ),
    );

    locator.registerFactory(
      () => HomeView(
        viewModel: locator<HomeViewModel>(),
      ),
    );

    locator.registerFactory(
      () => MainSkeletonView(
        viewModel: locator<MainSkeletonViewModel>(),
      ),
    );

    locator.registerFactory(
      () => MainSkeletonServiceProviderView(
        viewModel: locator<MainSkeletonServiceProviderViewModel>(),
      ),
    );
  }

  void addHome(ApplicationRouter router) {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
    _addViews(locator);

    router.addRoute(homeRoutes);
  }
}
