import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/routes.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view_model.dart';
import 'package:get_it/get_it.dart';

extension ServiceProviderProfileDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {}

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<AppRouter>();

    locator.registerFactory(
        () => ServiceProviderProfileViewModel(authProvider, router.appRouter));
  }

  void addServiceProviderProfile() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
