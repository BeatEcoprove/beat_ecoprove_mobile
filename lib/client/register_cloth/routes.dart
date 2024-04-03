import 'package:beat_ecoprove/client/register_cloth/presentation/register_cloth_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RegisterClothRoutes on AppRoute {
  static final registerCloth = AppRoute(path: "register-cloth");
}

final NavigationRoute registerClothRoute = NavigationRoute(
  route: RegisterClothRoutes.registerCloth,
  view: (BuildContext context, GoRouterState state) =>
      IView.of<RegisterClothView>(),
);
