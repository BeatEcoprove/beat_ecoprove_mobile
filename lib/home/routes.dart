import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton_service_provider/main_skeleton_service_provider_view.dart';

extension HomeRoutes on AppRoute {
  static final AppRoute home = AppRoute(path: "home");
}

final NavigationRoute homeRoutes = NavigationRoute(
  route: HomeRoutes.home,
  view: (context, state) => LinearView.of<MainSkeletonView>(),
);

extension ServiceProviderRoutes on AppRoute {
  static final AppRoute serviceProvider = AppRoute(path: "serviceProvider");
}

final NavigationRoute serviceProviderRoutes = NavigationRoute(
  route: ServiceProviderRoutes.serviceProvider,
  view: (context, state) => LinearView.of<MainSkeletonServiceProviderView>(),
);
