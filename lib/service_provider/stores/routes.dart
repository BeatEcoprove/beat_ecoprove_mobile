import 'package:beat_ecoprove/common/info_store/info_store_view.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/add_worker/add_worker_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension StoreRoutes on AppRoute {
  static final AppRoute store = AppRoute(path: "store");

  static final AppRoute createStore = AppRoute(path: "createStore");
  static final AppRoute detailsStore = AppRoute(path: "info/store/:id");
  static final AppRoute workers = AppRoute(path: "store/:id/workers");
  static final AppRoute addWorkers = AppRoute(path: "store/:id/addWorkers");
}

final NavigationRoute storeRoute = NavigationRoute(
  route: StoreRoutes.store,
  view: (BuildContext context, GoRouterState state) =>
      LinearView.of<StoreView>(),
  routes: [
    NavigationRoute(
      route: StoreRoutes.createStore,
      view: (context, state) => LinearView.of<CreateStoreView>(),
    ),
    NavigationRoute(
      route: StoreRoutes.detailsStore,
      view: (context, state) => ArgumentView.of<InfoStoreView>(state.extra),
    ),
    NavigationRoute(
      route: StoreRoutes.workers,
      view: (context, state) =>
          ArgumentView.of<StoreWorkersView>(state.extra as StoreParams),
    ),
    NavigationRoute(
      route: StoreRoutes.addWorkers,
      view: (context, state) => LinearView.of<AddWorkerView>(),
    ),
  ],
);
