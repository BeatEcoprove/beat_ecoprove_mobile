import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/home/contracts/service_provider_result.dart';
import 'package:beat_ecoprove/home/domain/models/service_provider_item.dart';
import 'package:beat_ecoprove/home/services/service_provider_service.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/store_result.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';

class GetServicesProvidersUseCaseRequest {
  final int page;
  final int pageSize;

  GetServicesProvidersUseCaseRequest({
    this.page = 1,
    this.pageSize = 100,
  });
}

class GetServicesProvidersUseCase
    implements
        UseCase<GetServicesProvidersUseCaseRequest,
            Future<List<ServiceProviderItem>>> {
  final ServiceProviderService _serviceProviderService;

  GetServicesProvidersUseCase(this._serviceProviderService);

  List<StoreItem> getStores(List<StoreResult> stores) {
    List<StoreItem> storesItems = [];

    for (var store in stores) {
      var storeCard = StoreItem(
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

      storesItems.add(storeCard);
    }

    return storesItems;
  }

  @override
  Future<List<ServiceProviderItem>> handle(request) async {
    List<ServiceProviderResult> servicesProvidersResult;
    List<ServiceProviderItem> servicesProviders = [];

    try {
      servicesProvidersResult =
          await _serviceProviderService.getServicesProviders(
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    for (var serviceProvider in servicesProvidersResult) {
      var serviceProviderCard = ServiceProviderItem(
        id: serviceProvider.id,
        name: serviceProvider.name,
        type: serviceProvider.type,
        picture: serviceProvider.picture,
        icon: serviceProvider.icon,
        rating: serviceProvider.rating,
        stores: getStores(serviceProvider.stores),
      );

      servicesProviders.add(serviceProviderCard);
    }

    return servicesProviders;
  }
}
