import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute registerClothRoutes = GoRoute(
  path: '/register-cloth',
  builder: (BuildContext context, GoRouterState state) =>
      const RegisterClothView(),
);
