import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/home/domain/models/service_provider_item.dart';
import 'package:beat_ecoprove/home/domain/use-cases/get_services_providers_use_case.dart';

class HomeViewModel extends ViewModel implements Clone {
  final AuthenticationProvider _authProvider;
  final ClosetService _closetService;
  final ActionService _actionService;
  final GetServicesProvidersUseCase _getServicesProvidersUseCase;
  late final User? user;
  late List<ServiceProviderItem> servicesProviders = [];

  HomeViewModel(
    this._authProvider,
    this._closetService,
    this._actionService,
    this._getServicesProvidersUseCase,
  ) {
    user = _authProvider.appUser;

    // Get all colors and brands at hand
    _closetService.getAllColors();
    _closetService.getAllBrands();
    _actionService.getAllServices();
    // getServiceProviders();
  }

  void getServiceProviders() async {
    servicesProviders = await _getServicesProvidersUseCase
        .handle(GetServicesProvidersUseCaseRequest());
  }

  @override
  HomeViewModel clone() {
    return HomeViewModel(
      _authProvider,
      _closetService,
      _actionService,
      _getServicesProvidersUseCase,
    );
  }
}
