import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute serviceProviderProfileRoutes = GoRoute(
  name: 'serviceProviderProfile',
  path: '/',
  builder: (BuildContext context, GoRouterState state) =>
      IView.of<ServiceProviderProfileView>(),
  routes: [],
);
