import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/advert_item.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/home/domain/models/service_provider_item.dart';
import 'package:beat_ecoprove/home/domain/use-cases/get_service_provider_adverts_use_case.dart';
import 'package:beat_ecoprove/home/presentation/brand/service_provider_params.dart';
import 'package:beat_ecoprove/home/services/service_provider_service.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';

class ServiceViewModel extends FormViewModel<ServiceProviderParams> {
  final AuthenticationProvider _authProvider;
  final ServiceProviderService _serviceProviderService;
  final GetServiceProviderAdvertsUseCase _getServiceProviderAdvertsUseCase;

  late final User? user;
  final List<StoreItem> stores = [];
  final List<AdvertItem> adverts = [];

  ServiceViewModel(
    this._authProvider,
    this._serviceProviderService,
    this._getServiceProviderAdvertsUseCase,
  ) {
    user = _authProvider.appUser;

    initializeFields([
      FormFieldValues.code,
    ]);
  }

  @override
  void initSync() async {
    if (arg == null) return;

    await getServiceProvider(arg!.serviceProviderId);
  }

  Future getServiceProvider(String serviceProviderId) async {
    try {
      var result = await _serviceProviderService
          .getDetailsServiceProvider(serviceProviderId);

      var serviceProvider = ServiceProviderItem(
        id: result.id,
        name: result.name,
        type: result.type,
        icon: result.icon,
        //TODO: CHANGE
        services: [],
        rating: result.rating,
      );

      setValue(
        FormFieldValues.code,
        serviceProvider,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future getStores(String serviceProviderId) async {
    try {
      var result = await _serviceProviderService
          .getStoresOfServiceProvider(serviceProviderId);

      var storesResult = result.map((store) {
        return StoreItem(
          id: store.id,
          name: store.name,
          numberWorkers: store.numberWorkers,
          country: store.country,
          locality: store.locality,
          street: store.street,
          postalCode: store.postalCode,
          numberPort: store.numberPort,
          sustainablePoints: store.sustainablePoints,
          rating: store.rating,
          picture: store.picture,
          level: store.level,
        );
      }).toList();

      stores.clear();
      stores.addAll(storesResult);
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAdverts(String serviceProviderId) async {
    try {
      var result = await _getServiceProviderAdvertsUseCase
          .handle(GetServiceProviderAdvertsUseCaseRequest(
        serviceProviderId: serviceProviderId,
      ));

      adverts.clear();
      adverts.addAll(result);
    } catch (e) {
      print(e.toString());
    }
  }
}
