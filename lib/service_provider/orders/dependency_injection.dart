import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view_model.dart';
import 'package:get_it/get_it.dart';

extension OrdersDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {}

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<AppRouter>();
    var notificationProvider = locator<NotificationProvider>();

    locator.registerFactory(() => OrdersViewModel(
          notificationProvider,
          authProvider,
          router.appRouter,
          locator<StaticValuesProvider>(),
        ));
  }

  void addOrders() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
