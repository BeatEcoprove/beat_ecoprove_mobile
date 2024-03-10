import 'package:beat_ecoprove/client/clothing/services/action_service_proxy.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/home/presentation/index/home_view_model.dart';
import 'package:get_it/get_it.dart';

extension HomeDependencyInjection on DependencyInjection {
  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var closetService = locator<ClosetService>();
    var actionService = locator<ActionServiceProxy>();

    locator.registerFactory(
        () => HomeViewModel(authProvider, closetService, actionService));
  }

  void addHome() {
    GetIt locator = DependencyInjection.locator;

    _addViewModels(locator);
  }
}
