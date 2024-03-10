import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute storeRoutes = GoRoute(
  name: 'stores',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => const StoreView(),
  routes: [
    GoRoute(
      path: 'createStore',
      builder: (context, state) => const CreateStoreView(),
    ),
  ],
);
