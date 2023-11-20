import 'package:beat_ecoprove/clothing/presentation/info_cloth/info_cloth_view.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute clothingRoutes = GoRoute(
  path: '/info/:id',
  builder: (BuildContext context, GoRouterState state) => InfoClothView(
    index: state.pathParameters['id'] ?? '0',
    card: state.extra as CardItem,
  ),
);
