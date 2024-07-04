import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/remove_store_request.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class RemoveStoreUseCase implements UseCase<RemoveStoreRequest, Future> {
  final StoreService _storeService;

  RemoveStoreUseCase(this._storeService);

  @override
  Future handle(RemoveStoreRequest request) async {
    try {
      await _storeService.removeStore(request);
    } catch (e) {
      rethrow;
    }
  }
}
