import 'package:beat_ecoprove/core/navigation/app_route.dart';
import 'package:beat_ecoprove/core/navigation/navigation_route.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/presentation/list_widget_view/list_widget_view.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/presentation/qr_code/qr_code_view.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_view.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_view.dart';

import 'argument_view.dart';

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

  static final AppRoute qrCode = AppRoute(
    path: "qr_code",
  );

  static final AppRoute listDetails = AppRoute(
    path: "list_details",
  );

  static final AppRoute listWidget = AppRoute(
    path: "list_widget",
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
      view: (context, state) => ArgumentView.of<ShowCompletedView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.makeProfileAction,
      view: (context, state) =>
          ArgumentView.of<MakeProfileActionView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.qrCode,
      view: (context, state) => ArgumentView.of<QRCodeView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.listDetails,
      view: (context, state) => ArgumentView.of<ListDetailsView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.listWidget,
      view: (context, state) => ArgumentView.of<ListWidgetView>(state.extra),
    ),
    NavigationRoute(
      route: CoreRoutes.selectService,
      view: (context, state) => ArgumentView.of<SelectServiceView>(state.extra),
    ),
  ],
);
