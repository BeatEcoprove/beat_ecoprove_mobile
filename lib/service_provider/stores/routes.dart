import 'package:beat_ecoprove/common/info_store/info_store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_index/store_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/add_worker/add_worker_view.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_form.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_workers_view.dart';
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
    GoRoute(
      path: 'info/store/:id',
      builder: (context, state) =>
          InfoStoreView(card: state.extra as StoreItem),
    ),
    GoRoute(
      path: 'store/:id/workers',
      builder: (context, state) => StoreWorkersView(
        storeParams: state.extra as StoreParams,
      ),
    ),
    GoRoute(
      path: 'store/:id/addWorkers',
      builder: (context, state) => const AddWorkerView(),
    ),
  ],
);
