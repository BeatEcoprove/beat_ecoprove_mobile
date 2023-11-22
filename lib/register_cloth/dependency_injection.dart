import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension RegisterClothInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {}

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();

    locator.registerFactory(() => RegisterClothViewModel(authProvider));
  }

  void addCloth() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
