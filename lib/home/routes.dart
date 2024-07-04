import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_view.dart';
import 'package:beat_ecoprove/home/presentation/main_skeleton/main_skeleton_view.dart';

extension HomeRoutes on AppRoute {
  static final AppRoute home = AppRoute(path: "home");
  static final serviceProvider = AppRoute(path: "serviceProvider");
}

final NavigationRoute homeRoutes = NavigationRoute(
    route: HomeRoutes.home,
    view: (context, state) => LinearView.of<MainSkeletonView>(),
    routes: [
      NavigationRoute(
        route: HomeRoutes.serviceProvider,
        view: (context, state) =>
            ArgumentView.of<ServiceView>(state.extra as ServiceProviderParams),
      ),
    ]);
