import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton_service_provider/main_skeleton_service_provider_view.dart';
import 'package:beat_ecoprove/service_provider/orders/routes.dart';
import 'package:beat_ecoprove/service_provider/profile/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';

extension ServiceProviderRoutes on AppRoute {
  static final AppRoute serviceProvider = AppRoute(path: "serviceProvider");
}

final NavigationRoute serviceProviderRoutes = NavigationRoute(
  route: ServiceProviderRoutes.serviceProvider,
  view: (context, state) => LinearView.of<MainSkeletonServiceProviderView>(),
  routes: [
    orderRoutes,
    serviceProviderProfileRoute,
    storeRoute,
  ],
);
