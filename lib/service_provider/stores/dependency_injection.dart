import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/register_store_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';
import 'package:get_it/get_it.dart';

extension StoresDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => StoreService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var storeService = locator<StoreService>();

    locator.registerSingleton(RegisterStoreUseCase(storeService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var navigator = locator<AppRouter>();
    var notificationProvider = locator<NotificationProvider>();
    var registerStoreUseCase = locator<RegisterStoreUseCase>();

    locator.registerFactory(() => StoreViewModel(
          authProvider,
          navigator.appRouter,
        ));
    locator.registerFactory(() => CreateStoreViewModel(
          notificationProvider,
          registerStoreUseCase,
          navigator.appRouter,
        ));
  }

  void addStore() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
