import 'package:beat_ecoprove/client/profile/presentation/change_profile/change_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/prizes/prizes_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/send_feedback/send_feedback_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/settings/settings_view.dart';
import 'package:beat_ecoprove/client/profile/presentation/trade_points/trade_points_view.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ProfileRoutes on AppRoute {
  static final AppRoute profile = AppRoute(path: "profile");

  static final AppRoute settings = AppRoute(path: "settings");

  static final AppRoute feedback = AppRoute(path: "feedback");

  static final AppRoute prizes = AppRoute(path: "prizes");

  static final AppRoute tradepoints = AppRoute(path: "tradepoints");

  static final AppRoute changeProfile = AppRoute(path: "changeProfile");

  static final AppRoute createprofile = AppRoute(path: "createProfile");

  static final AppRoute addparams = AppRoute(path: "addparams");
}

final NavigationRoute profileRoute = NavigationRoute(
  route: ProfileRoutes.profile,
  view: (BuildContext context, GoRouterState state) =>
      LinearView.of<ProfileView>(),
  routes: [
    NavigationRoute(
      route: ProfileRoutes.settings,
      view: (context, state) => LinearView.of<SettingsView>(),
    ),
    NavigationRoute(
      route: ProfileRoutes.feedback,
      view: (context, state) => LinearView.of<SendFeedbackView>(),
    ),
    NavigationRoute(
      route: ProfileRoutes.prizes,
      view: (context, state) => LinearView.of<PrizesView>(),
    ),
    NavigationRoute(
      route: ProfileRoutes.tradepoints,
      view: (context, state) => LinearView.of<TradePointsView>(),
    ),
    NavigationRoute(
      route: ProfileRoutes.changeProfile,
      view: (context, state) => LinearView.of<ChangeProfileView>(),
    ),
    NavigationRoute(
      route: ProfileRoutes.createprofile,
      view: (context, state) => LinearView.of<CreateProfileView>(),
    ),
    NavigationRoute(
      route: ProfileRoutes.addparams,
      view: (context, state) => ArgumentView.of<ParamsProfileView>(
        state.extra,
      ),
    ),
  ],
);
