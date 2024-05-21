import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/store_result.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class GetStoresUseCaseRequest {
  final Map<String, String> params;
  final int page;
  final int pageSize;

  GetStoresUseCaseRequest(
    this.params, {
    this.page = 1,
    this.pageSize = 10,
  });
}

class GetStoresUseCase
    implements UseCase<GetStoresUseCaseRequest, Future<List<StoreItem>>> {
  final StoreService _storeService;

  GetStoresUseCase(this._storeService);

  @override
  Future<List<StoreItem>> handle(request) async {
    List<StoreResult> storeResult;
    List<StoreItem> stores = [];
    String filters = '';

    if (request.params.isNotEmpty) {
      filters = _prepareRequest(request.params);
    }

    try {
      storeResult = await _storeService.getStores(
        filters,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    for (var store in storeResult) {
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

      stores.add(storeCard);
    }

    return stores;
  }

  String _prepareRequest(Map<String, String> params) {
    Set<String> tags = {};
    String endPoint = '&';

    for (var param in params.values) {
      tags.add(param);
    }

    for (var tag in tags) {
      endPoint +=
          '$tag=${params.entries.where((entry) => entry.value.contains(tag)).map((entry) => entry.key).join(',')}';
      endPoint += '&';
    }

    return endPoint;
  }
}
