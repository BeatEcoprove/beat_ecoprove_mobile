import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ServiceProviderProfileRoutes on AppRoute {
  static final AppRoute serviceProfile =
      AppRoute(path: "serviceProviderProfile");
}

final NavigationRoute serviceProviderProfileRoute = NavigationRoute(
  route: ServiceProviderProfileRoutes.serviceProfile,
  view: (BuildContext context, GoRouterState state) =>
      LinearView.of<ServiceProviderProfileView>(),
);
