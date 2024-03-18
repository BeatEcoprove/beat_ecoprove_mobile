import 'package:beat_ecoprove/client/clothing/presentation/closet/clothing_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_params.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_cloth_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_parmas.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_services_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/swiper/swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute clothingRoutes = GoRoute(
  name: 'closet',
  path: '/',
  builder: (BuildContext context, GoRouterState state) =>
      IView.of<ClothingView>(),
  routes: [
    GoRoute(
      path: 'info/cloth/:id',
      builder: (BuildContext context, GoRouterState state) {
        double maxWidth = (MediaQuery.of(context).size.width / 2) - 50;

        return Swiper(
          views: [
            ArgumentedView.of<InfoClothView>(
              InfoClothParams(
                state.pathParameters['id'] ?? '0',
                state.extra as CardItem,
              ),
            ),
            ArgumentedView.of<InfoClothServiceView>(
              InfoClothServiceParms(
                state.extra as CardItem,
              ),
            ),
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
            ArgumentedView.of<InfoBucketView>(
              InfoBucketParams(
                state.pathParameters['id'] ?? '0',
                state.extra as CardItem,
              ),
            ),
            ArgumentedView.of<InfoClothServiceView>(
              InfoClothServiceParms(
                state.extra as CardItem,
              ),
            ),
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
      routes: [
        GoRoute(
          path: 'change_name',
          builder: (context, state) => ArgumentedView.of<ChangeBucketNameView>(
            ChangeBucketNameParams(
              state.extra as CardItem,
            ),
          ),
        ),
      ],
    ),
  ],
);
