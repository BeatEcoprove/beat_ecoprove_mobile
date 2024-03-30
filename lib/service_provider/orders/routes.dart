import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/orders/orders_index/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute orderRoutes = GoRoute(
  name: 'orders',
  path: '/',
  builder: (BuildContext context, GoRouterState state) =>
      IView.of<OrdersView>(),
  routes: [],
);
