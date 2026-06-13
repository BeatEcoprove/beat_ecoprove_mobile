import 'package:beat_ecoprove/client/game/presentation/quiz_view.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GameRoutes on AppRoute {
  static final game = AppRoute(path: "game");
}

final NavigationRoute gameRoute = NavigationRoute(
  route: GameRoutes.game,
  view: (BuildContext context, GoRouterState state) =>
      LinearView.of<QuizView>(),
);
