import 'package:beat_ecoprove/common/info_store/info_store_view.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/add_worker/add_worker_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute storeRoutes = GoRoute(
  name: 'stores',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => IView.of<StoreView>(),
  routes: [
    GoRoute(
      path: 'createStore',
      builder: (context, state) => IView.of<CreateStoreView>(),
    ),
    GoRoute(
      path: 'info/store/:id',
      builder: (context, state) =>
          ArgumentedView.of<InfoStoreView>(state.extra),
    ),
    GoRoute(
      path: 'store/:id/workers',
      builder: (context, state) =>
          ArgumentedView.of<StoreWorkersView>(state.extra as StoreParams),
    ),
    GoRoute(
      path: 'store/:id/addWorkers',
      builder: (context, state) => IView.of<AddWorkerView>(),
    ),
  ],
);
