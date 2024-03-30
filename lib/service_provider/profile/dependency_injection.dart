import 'package:beat_ecoprove/application_router.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view_model.dart';
import 'package:beat_ecoprove/service_provider/profile/routes.dart';
import 'package:get_it/get_it.dart';

extension ServiceProviderProfileDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {}

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<INavigationManager>();

    locator.registerFactory(
      () => ServiceProviderProfileViewModel(
        authProvider,
        router,
      ),
    );
  }

  void _addViews(GetIt locator) {
    locator.registerFactory(
      () => ServiceProviderProfileView(
        viewModel: locator<ServiceProviderProfileViewModel>(),
      ),
    );
  }

  void addServiceProviderProfile(ApplicationRouter router) {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);

    router.addRoute(serviceProviderProfileRoutes);
  }
}
