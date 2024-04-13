import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/client/register_cloth/presentation/register_cloth_view.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/client/register_cloth/domain/use-cases/register_cloth_use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/presentation/register_cloth_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:get_it/get_it.dart';

extension RegisterClothInjection on DependencyInjection {
  void _addServices(GetIt locator) {}

  void _addUseCases(GetIt locator) {
    var closetService = locator<ClosetService>();

    locator.registerSingleton(RegisterClothUseCase(closetService));
  }

  void _addViewModels(GetIt locator) {
    var authProvider = locator<AuthenticationProvider>();
    var notificationProvider = locator<INotificationProvider>();
    var registerClothUseCase = locator<RegisterClothUseCase>();
    var nagivator = locator<INavigationManager>();

    locator.registerFactory(
      () => RegisterClothViewModel(
        notificationProvider,
        authProvider,
        registerClothUseCase,
        nagivator,
        locator<StaticValuesProvider>(),
      ),
    );
  }

  void _addView(GetIt locator) {
    locator.registerFactory(
      () => RegisterClothView(
        viewModel: locator<RegisterClothViewModel>(),
      ),
    );
  }

  void addRegisterCloth() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addView(locator);
  }
}
