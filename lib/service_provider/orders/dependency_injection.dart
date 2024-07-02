import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/orders/domain/use-cases/get_orders_use_case.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view_model.dart';
import 'package:beat_ecoprove/service_provider/orders/services/order_service.dart';
import 'package:get_it/get_it.dart';

extension OrdersDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(
      () => OrderService(httpClient),
    );
  }

  void _addUseCases(GetIt locator) {
    var orderService = locator<OrderService>();

    locator.registerSingleton(
      GetOrdersUseCase(orderService),
    );
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var notificationProvider = locator<INotificationProvider>();
    var getOrdersUseCase = locator<GetOrdersUseCase>();
    var router = locator<INavigationManager>();

    locator.registerFactory(
      () => OrdersViewModel(
        router,
        notificationProvider,
        authProvider,
        locator<StaticValuesProvider>(),
        getOrdersUseCase,
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactory(
      () => OrdersView(viewModel: locator<OrdersViewModel>()),
    );
  }

  void addOrders() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);
  }
}
