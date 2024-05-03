import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view_model.dart';
import 'package:get_it/get_it.dart';

extension OrdersDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {}

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();

    locator.registerFactory(
      () => OrdersViewModel(
        authProvider,
        locator<StaticValuesProvider>(),
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
