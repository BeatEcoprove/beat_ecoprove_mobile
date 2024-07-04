import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/home/domain/models/service_provider_item.dart';
import 'package:beat_ecoprove/home/domain/use-cases/get_services_providers_use_case.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/routes.dart';

class HomeViewModel extends ViewModel implements Clone {
  final AuthenticationProvider _authProvider;
  final ClosetService _closetService;
  final ActionService _actionService;
  final GetServicesProvidersUseCase _getServicesProvidersUseCase;
  final INavigationManager _navigationManager;
  final StaticValuesProvider _valuesProvider;

  late final User? user;
  final List<ServiceProviderItem> servicesProviders = [];

  HomeViewModel(
    this._authProvider,
    this._closetService,
    this._actionService,
    this._getServicesProvidersUseCase,
    this._navigationManager,
    this._valuesProvider,
  ) {
    user = _authProvider.appUser;

    servicesProviders.addAll(_valuesProvider.servicesProvidersList);
  }

  void goToInfoService(ServiceProviderItem service) {
    _navigationManager.push(HomeRoutes.serviceProvider,
        extras: ServiceProviderParams(
          serviceProviderId: service.id,
          name: service.name,
          type: service.type,
          picture: service.icon,
        ));
  }

  @override
  HomeViewModel clone() {
    return HomeViewModel(
      _authProvider,
      _closetService,
      _actionService,
      _getServicesProvidersUseCase,
      _navigationManager,
      _valuesProvider,
    );
  }
}
