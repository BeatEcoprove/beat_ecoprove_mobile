import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ServiceProviderProfileRoutes on AppRoute {
  static final AppRoute serviceProfile =
      AppRoute(path: "serviceProviderProfile");

  static final registerAdvert = AppRoute(path: "registerAdvert");
}

final NavigationRoute serviceProviderProfileRoute = NavigationRoute(
    route: ServiceProviderProfileRoutes.serviceProfile,
    view: (BuildContext context, GoRouterState state) =>
        LinearView.of<ServiceProviderProfileView>(),
    routes: [
      NavigationRoute(
        route: ServiceProviderProfileRoutes.registerAdvert,
        view: (context, state) => ArgumentView.of<CreatePrizeView>(state.extra),
      ),
    ]);
