import 'package:beat_ecoprove/group/presentation/group_index/group_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute groupRoutes = GoRoute(
  name: 'group',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => const GroupView(),
);
