import 'package:beat_ecoprove/client/clothing/presentation/detail_card/detail_card.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_params.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_cloth_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_parms.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_view.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_params.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/view.dart';

extension ClothingRoutes on AppRoute {
  static final AppRoute closet = AppRoute(
    path: "closet",
  );

  static final AppRoute clothDetails = AppRoute(
    path: "info/cloth/:id",
  );

  static AppRoute setClothDetails(String id) {
    return AppRoute.withParent(closet, "info/cloth/$id");
  }

  static final AppRoute bucketDetails = AppRoute(
    path: "info/bucket/:id",
  );

  static AppRoute setBucketDetails(String id) {
    return AppRoute.withParent(closet, "info/bucket/$id");
  }

  static final AppRoute changeBucketName = AppRoute(
    path: "change_name",
  );

  static AppRoute setChangeBucketName(String id) {
    return setBucketDetails("$id/change_name");
  }
}

NavigationRoute clothingRoute = NavigationRoute(
  route: ClothingRoutes.closet,
  routes: [
    NavigationRoute(
      route: ClothingRoutes.clothDetails,
      view: (context, state) => DetailSwiper(
        views: [
          ArgumentedView.of<InfoClothView>(
            InfoClothParams(
              state.pathParameters['id'] ?? '0',
              state.extra as CardItem,
            ),
          ),
          ArgumentedView.of<InfoClothServiceViewAlt>(
            InfoClothServiceParms(
              state.extra as CardItem,
            ),
          ),
        ],
      ),
    ),
    NavigationRoute(
      route: ClothingRoutes.bucketDetails,
      view: (context, state) => DetailSwiper(
        views: [
          ArgumentedView.of<InfoBucketView>(
            InfoBucketParams(
              state.pathParameters['id'] ?? '0',
              state.extra as CardItem,
            ),
          ),
          ArgumentedView.of<InfoClothServiceViewAlt>(
            InfoClothServiceParms(
              state.extra as CardItem,
            ),
          ),
        ],
      ),
      routes: [
        NavigationRoute(
          route: ClothingRoutes.changeBucketName,
          view: (context, state) => ArgumentedView.of<ChangeBucketNameView>(
            ChangeBucketNameParams(
              state.extra as CardItem,
            ),
          ),
        ),
      ],
    ),
  ],
);
