import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_view.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_view.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute coreRoutes = GoRoute(
  name: 'core',
  path: '/extension',
  builder: (BuildContext context, GoRouterState state) =>
      IView.of<ProfileView>(),
  routes: [
    GoRoute(
      path: 'show_completed',
      builder: (context, state) =>
          ArgumentedView.of<ShowCompletedView>(state.extra),
    ),
    GoRoute(
      path: 'make_profile_action',
      builder: (context, state) =>
          ArgumentedView.of<MakeProfileActionView>(state.extra),
    ),
    GoRoute(
      path: 'list_details',
      builder: (context, state) =>
          ArgumentedView.of<ListDetailsView>(state.extra),
    ),
    GoRoute(
      path: 'select_service',
      builder: (context, state) =>
          ArgumentedView.of<SelectServiceView>(state.extra),
    ),
  ],
);
