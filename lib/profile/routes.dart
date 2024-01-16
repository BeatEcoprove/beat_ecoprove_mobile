import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/profile/presentation/change_profile/change_profile_view.dart';
import 'package:beat_ecoprove/profile/presentation/change_profile/params_page/params_profile_view.dart';
import 'package:beat_ecoprove/profile/presentation/create_profile/create_profile_view.dart';
import 'package:beat_ecoprove/profile/presentation/prizes/prizes_view.dart';
import 'package:beat_ecoprove/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/profile/presentation/settings/settings_view.dart';
import 'package:beat_ecoprove/profile/presentation/trade_points/trade_points_view.dart';
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
    GoRoute(
      path: 'prizes',
      builder: (context, state) => const PrizesView(),
    ),
    GoRoute(
      path: 'tradepoints',
      builder: (context, state) => const TradePointsView(),
    ),
    GoRoute(
      path: 'changeprofile',
      builder: (context, state) => const ChangeProfileView(),
    ),
    GoRoute(
      path: 'createprofile',
      builder: (context, state) => const CreateProfileView(),
    ),
    GoRoute(
      path: 'addparams',
      builder: (context, state) =>
          ParamsProfileView(params: state.extra as String),
    ),
  ],
);
