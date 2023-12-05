import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/info_bucket_view.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_cloth/info_cloth_view.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute clothingRoutes = GoRoute(
  name: 'closet',
  path: '/',
  builder: (BuildContext context, GoRouterState state) => const ClothingView(),
  routes: [
    GoRoute(
      path: 'info/cloth/:id',
      builder: (BuildContext context, GoRouterState state) {
        double maxWidth = (MediaQuery.of(context).size.width / 2) - 50;

        return Swiper(
          views: [
            InfoClothView(
              index: state.pathParameters['id'] ?? '0',
              card: state.extra as CardItem,
            ),
            const InfoClothServiceView(),
          ],
          bottomNavigationBarOptions: [
            Line(
              width: maxWidth,
              color: AppColor.primaryColor,
              stroke: 3,
            ),
            Line(
              width: maxWidth,
              color: AppColor.primaryColor,
              stroke: 3,
            )
          ],
          hasRegisterCloth: false,
        );
      },
    ),
    GoRoute(
      path: 'info/bucket/:id',
      builder: (BuildContext context, GoRouterState state) {
        double maxWidth = (MediaQuery.of(context).size.width / 2) - 50;

        return Swiper(
          views: [
            InfoBucketView(
              index: state.pathParameters['id'] ?? '0',
              card: state.extra as CardItem,
            ),
            const InfoClothServiceView(),
          ],
          bottomNavigationBarOptions: [
            Line(
              width: maxWidth,
              color: AppColor.primaryColor,
              stroke: 3,
            ),
            Line(
              width: maxWidth,
              color: AppColor.primaryColor,
              stroke: 3,
            )
          ],
          hasRegisterCloth: false,
        );
      },
    ),
  ],
);
