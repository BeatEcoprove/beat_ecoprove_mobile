import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/default_layout/presentation/default_layout_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute homeRoutes = GoRoute(
  name: 'home',
  path: '/',
  builder: (BuildContext context, GoRouterState state) =>
      const DefaultLayoutView(
    header: StandardHeader(sustainablePoints: 100),
  ),
);
