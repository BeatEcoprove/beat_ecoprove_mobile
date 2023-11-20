import 'package:beat_ecoprove/clothing/presentation/clothing_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension ClothingDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    locator.registerFactory(() => ClothingViewModel(authProvider));
  }

  void addCloth() {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
  }
}
