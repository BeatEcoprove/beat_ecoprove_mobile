import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_model.dart';
import 'package:get_it/get_it.dart';

extension HomeDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();

    locator.registerFactory(() => HomeViewModel(authProvider));
  }

  void addHome() {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
  }
}
