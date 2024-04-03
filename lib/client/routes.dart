import 'package:beat_ecoprove/client/clothing/routes.dart';
import 'package:beat_ecoprove/client/profile/routes.dart';
import 'package:beat_ecoprove/client/register_cloth/routes.dart';
import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';

extension ClientRoutes on AppRoute {
  static final AppRoute client = AppRoute(
    path: "client",
  );
}

NavigationRoute clientRoutes = NavigationRoute(
  route: ClientRoutes.client,
  routes: [
    clothingRoute,
    profileRoute,
    registerClothRoute,
  ],
);
