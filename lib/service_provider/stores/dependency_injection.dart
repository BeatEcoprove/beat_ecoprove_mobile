import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/common/info_store/info_store_params.dart';
import 'package:beat_ecoprove/common/info_store/info_store_view.dart';
import 'package:beat_ecoprove/common/info_store/info_store_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/register_store_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/add_worker/add_worker_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/add_worker/add_worker_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';
import 'package:get_it/get_it.dart';

extension StoresDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(
      () => StoreService(httpClient),
    );
  }

  void _addUseCases(GetIt locator) {
    var storeService = locator<StoreService>();

    locator.registerSingleton(
      RegisterStoreUseCase(storeService),
    );
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<INavigationManager>();
    var notificationProvider = locator<INotificationProvider>();
    var registerStoreUseCase = locator<RegisterStoreUseCase>();

    locator.registerFactory(
      () => StoreViewModel(
        authProvider,
        router,
      ),
    );

    locator.registerFactory(
      () => CreateStoreViewModel(
        notificationProvider,
        registerStoreUseCase,
        router,
      ),
    );

    locator.registerFactory(
      () => InfoStoreViewModel(
        router,
      ),
    );

    locator.registerFactory(
      () => StoreWorkersViewModel(
        authProvider,
        router,
      ),
    );

    locator.registerFactory(
      () => AddWorkerViewModel(
        notificationProvider,
        router,
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactory(
      () => StoreView(
        viewModel: locator<StoreViewModel>(),
      ),
    );

    locator.registerFactory(
      () => CreateStoreView(
        viewModel: locator<CreateStoreViewModel>(),
      ),
    );

    locator.registerFactoryParam<InfoStoreView, InfoStoreParams, void>(
      (params, _) => InfoStoreView(
        viewModel: locator<InfoStoreViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<StoreWorkersView, StoreParams, void>(
      (params, _) => StoreWorkersView(
        viewModel: locator<StoreWorkersViewModel>(),
        args: params,
      ),
    );

    locator.registerFactory(
      () => AddWorkerView(
        viewModel: locator<AddWorkerViewModel>(),
      ),
    );
  }

  void addStore(ApplicationRouter router) {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);

    router.addRoute(storeRoute);
  }
}
