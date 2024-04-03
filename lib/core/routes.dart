import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_view.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_view.dart';
import 'package:beat_ecoprove/core/view.dart';

extension CoreRoutes on AppRoute {
  static final AppRoute core = AppRoute(
    path: "extension",
  );

  static final AppRoute showCompleted = AppRoute(
    path: "show_completed",
  );

  static final AppRoute makeProfileAction = AppRoute(
    path: "make_profile_action",
  );

  static final AppRoute listDetails = AppRoute(
    path: "list_details",
  );

  static final AppRoute selectService = AppRoute(
    path: "select_service",
  );
}

NavigationRoute coreRoutes = NavigationRoute(
  route: CoreRoutes.core,
  routes: [
    NavigationRoute(
      route: CoreRoutes.showCompleted,
      view: (context, state) =>
          ArgumentedView.of<ShowCompletedView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.makeProfileAction,
      view: (context, state) =>
          ArgumentedView.of<MakeProfileActionView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.listDetails,
      view: (context, state) => ArgumentedView.of<ListDetailsView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.selectService,
      view: (context, state) =>
          ArgumentedView.of<SelectServiceView>(state.extra),
    ),
  ],
);
