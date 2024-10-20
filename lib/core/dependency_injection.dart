import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_params.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view.dart';
import 'package:beat_ecoprove/core/presentation/list_view/list_details_view_model.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make%20_profile_action_view.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make_profile_action_params.dart';
import 'package:beat_ecoprove/core/presentation/make_profile_action/make_profile_action_view_model.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_params.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_view.dart';
import 'package:beat_ecoprove/core/presentation/select_service/select_service_view_model.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_view.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_view_model.dart';
import 'package:beat_ecoprove/core/routes.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension CoreDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var router = locator<INavigationManager>();

    locator.registerFactory(
      () => ListDetailsViewModel(),
    );

    locator.registerFactory(
      () => MakeProfileActionViewModel(
        router,
      ),
    );

    locator.registerFactory(
      () => SelectServiceViewModel(),
    );

    locator.registerFactory(
      () => ShowCompltedViewModel(),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactoryParam<ListDetailsView, ListDetailsViewParams, void>(
      (params, _) => ListDetailsView(
        viewModel: locator<ListDetailsViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<MakeProfileActionView,
        MakeProfileActionViewParams, void>(
      (params, _) => MakeProfileActionView(
        viewModel: locator<MakeProfileActionViewModel>(),
        args: params,
      ),
    );

    locator.registerFactoryParam<SelectServiceView, ServiceParams, void>(
      (params, _) => SelectServiceView(
        viewModel: locator<SelectServiceViewModel>(),
        args: params,
      ),
    );

    locator
        .registerFactoryParam<ShowCompletedView, ShowCompletedViewParams, void>(
      (params, _) => ShowCompletedView(
        viewModel: locator<ShowCompltedViewModel>(),
        args: params,
      ),
    );
  }

  void addCore(ApplicationRouter router) {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
    _addViews(locator);

    router.addRoute(coreRoutes);
  }
}
