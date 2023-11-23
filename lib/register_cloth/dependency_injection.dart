import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/register_cloth_use_case.dart';
import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/register_cloth/services/register_cloth_service.dart';
import 'package:get_it/get_it.dart';

extension RegisterClothInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(() => RegisterClothService(httpClient));
  }

  void _addUseCases(GetIt locator) {
    var registerClothService = locator<RegisterClothService>();

    locator.registerSingleton(RegisterClothUseCase(registerClothService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var registerClothUseCase = locator<RegisterClothUseCase>();

    locator.registerFactory(
        () => RegisterClothViewModel(authProvider, registerClothUseCase));
  }

  void addCloth() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
