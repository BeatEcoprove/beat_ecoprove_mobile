import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/orders/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/profile/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/dependency_injection.dart';

extension ServiceProviderDependencyInjection on DependencyInjection {
  void addServiceProvider(ApplicationRouter applicationRouter) {
    addOrders();
    addServiceProviderProfile();
    addStore();

    applicationRouter.addRoute(serviceProviderRoutes);
  }
}
