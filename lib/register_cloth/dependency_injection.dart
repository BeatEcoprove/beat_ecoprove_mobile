import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_brands_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/get_colors_use_case.dart';
import 'package:beat_ecoprove/register_cloth/domain/use-cases/register_cloth_use_case.dart';
import 'package:beat_ecoprove/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension RegisterClothInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {
    var closetService = locator<ClosetService>();

    locator.registerSingleton(RegisterClothUseCase(closetService));
    locator.registerSingleton(GetColorsUseCase(closetService));
    locator.registerSingleton(GetBrandsUseCase(closetService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var registerClothUseCase = locator<RegisterClothUseCase>();
    var getColorsUseCase = locator<GetColorsUseCase>();
    var getBrandsUseCase = locator<GetBrandsUseCase>();

    locator.registerFactory(() => RegisterClothViewModel(
          authProvider,
          registerClothUseCase,
          getColorsUseCase,
          getBrandsUseCase,
        ));
  }

  void addCloth() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
  }
}
