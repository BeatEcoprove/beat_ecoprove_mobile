import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/profile/domain/use-cases/register_prize_use_case.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_params.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/create_prize/create_prize_view_model.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view.dart';
import 'package:beat_ecoprove/service_provider/profile/presentation/profile/profile_view_model.dart';
import 'package:beat_ecoprove/service_provider/profile/services/adverts_service.dart';
import 'package:get_it/get_it.dart';

extension ServiceProviderProfileDependencyInjection on DependencyInjection {
  void _addServices(GetIt locator) {
    var httpClient = locator<HttpAuthClient>();

    locator.registerFactory(
      () => AdvertsService(httpClient),
    );
  }

  void _addUseCases(GetIt locator) {
    var advertService = locator<AdvertsService>();

    locator.registerSingleton(
      RegisterAdvertUseCase(advertService),
    );
  }

  void _addViewModels(GetIt locator) {
    var notificationProvider = locator<INotificationProvider>();
    var authProvider = locator<AuthenticationProvider>();
    var router = locator<INavigationManager>();
    var registerAdvertUseCase = locator<RegisterAdvertUseCase>();

    locator.registerFactory(
      () => ServiceProviderProfileViewModel(
        authProvider,
        router,
        locator<AdvertsService>(),
        notificationProvider,
      ),
    );

    locator.registerFactory(
      () => CreatePrizeViewModel(
        notificationProvider,
        registerAdvertUseCase,
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

    locator.registerFactoryParam<CreatePrizeView, CreatePrizeParams, void>(
      (params, _) => CreatePrizeView(
        viewModel: locator<CreatePrizeViewModel>(),
        args: params,
      ),
    );
  }

  void addServiceProviderProfile() {
    GetIt locator = DependencyInjection.locator;

    _addServices(locator);
    _addUseCases(locator);
    _addViewModels(locator);
    _addViews(locator);
  }
}
