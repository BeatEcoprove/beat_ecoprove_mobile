import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension OrderRoutes on AppRoute {
  static final AppRoute order = AppRoute(path: "orders");
}

final NavigationRoute orderRoutes = NavigationRoute(
  route: OrderRoutes.order,
  view: (BuildContext context, GoRouterState state) => IView.of<OrdersView>(),
);
