import 'package:beat_ecoprove/clothing/presentation/closet/clothing_view_model.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/clothing/use-cases/get_closet_use_case.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension ClothingDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => ClosetService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var clothingService = locator<ClosetService>();

    locator.registerSingleton(GetClosetUseCase(clothingService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var getClosetUseCase = locator<GetClosetUseCase>();

    locator.registerFactory(
        () => ClothingViewModel(authProvider, getClosetUseCase));
    locator.registerFactory(() => InfoClothServiceViewModel());
  }

  void addClothing() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
