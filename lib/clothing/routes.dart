import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/headers/standard_header.dart';
import 'package:beat_ecoprove/default_layout/presentation/default_layout_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute clothingRoutes = GoRoute(
  name: 'clothing',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => DefaultLayoutView(
    header: StandardHeader(
      title: "Vestuário",
      sustainablePoints: user.sustainablePoints,
    ),
  ),
);
