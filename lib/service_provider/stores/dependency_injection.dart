import 'package:beat_ecoprove/common/info_store/info_store_params.dart';
import 'package:beat_ecoprove/common/info_store/info_store_view.dart';
import 'package:beat_ecoprove/common/info_store/info_store_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_reviews_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_store_workers_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/add_worker_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_stores_use_case.dart';
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
      GetStoresUseCase(storeService),
    );

    locator.registerSingleton(
      RegisterStoreUseCase(storeService),
    );

    locator.registerSingleton(
      AddWorkerUseCase(storeService),
    );

    locator.registerSingleton(
      GetStoreWorkersUseCase(storeService),
    );

    locator.registerSingleton(
      GetReviewsUseCase(storeService),
    );
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<INavigationManager>();
    var notificationProvider = locator<INotificationProvider>();
    var registerStoreUseCase = locator<RegisterStoreUseCase>();
    var addWorkerUseCase = locator<AddWorkerUseCase>();
    var getStoreWorkersUseCase = locator<GetStoreWorkersUseCase>();
    var getReviewsUseCase = locator<GetReviewsUseCase>();
    var getStoresUseCase = locator<GetStoresUseCase>();

    locator.registerFactory(
      () => StoreViewModel(
        notificationProvider,
        authProvider,
        router,
        getStoresUseCase,
      ),
    );

    locator.registerFactory(
      () => CreateStoreViewModel(
        locator<StaticValuesProvider>(),
        notificationProvider,
        registerStoreUseCase,
        router,
      ),
    );

    locator.registerFactory(
      () => InfoStoreViewModel(
        notificationProvider,
        router,
        authProvider,
        getReviewsUseCase,
      ),
    );

    locator.registerFactory(
      () => StoreWorkersViewModel(
        notificationProvider,
        authProvider,
        router,
        getStoreWorkersUseCase,
        locator<StoreService>(),
      ),
    );

    locator.registerFactory(
      () => AddWorkerViewModel(
        notificationProvider,
        router,
        addWorkerUseCase,
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

    locator.registerFactoryParam<AddWorkerView, StoreParams, void>(
      (params, _) => AddWorkerView(
        viewModel: locator<AddWorkerViewModel>(),
        args: params,
      ),
    );
  }

  void addStore() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);
  }
}
