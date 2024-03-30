import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/prizes/prizes_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/send_feedback/send_feedback_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/settings_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/trade_points/trade_points_view.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute profileRoutes = GoRoute(
  name: 'profile',
  path: '/',
  builder: (BuildContext context, GoRouterState state) =>
      IView.of<ProfileView>(),
  routes: [
    GoRoute(
      path: 'settings',
      builder: (context, state) => IView.of<SettingsView>(),
    ),
    GoRoute(
      path: 'feedback',
      builder: (context, state) => IView.of<SendFeedbackView>(),
    ),
    GoRoute(
      path: 'prizes',
      builder: (context, state) => IView.of<PrizesView>(),
    ),
    GoRoute(
      path: 'tradepoints',
      builder: (context, state) => IView.of<TradePointsView>(),
    ),
    GoRoute(
      path: 'changeprofile',
      builder: (context, state) => IView.of<ChangeProfileView>(),
    ),
    GoRoute(
      path: 'createprofile',
      builder: (context, state) => IView.of<CreateProfileView>(),
    ),
    GoRoute(
      path: 'addparams',
      builder: (context, state) => ArgumentedView.of<ParamsProfileView>(
        state.extra,
      ),
    ),
  ],
);
