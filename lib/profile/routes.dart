import 'package:beat_ecoprove/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/profile/presentation/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute profileRoutes = GoRoute(
  name: 'profile',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => const ProfileView(),
  routes: [
    GoRoute(
      path: 'settings',
      builder: (context, state) => const SettingsView(),
    ),
  ],
);
