import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/remove_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class RemoveWorkerUseCase implements UseCase<RemoveWorkerRequest, Future> {
  final StoreService _storeService;

  RemoveWorkerUseCase(this._storeService);

  @override
  Future handle(RemoveWorkerRequest request) async {
    try {
      await _storeService.removeWorker(request);
    } catch (e) {
      rethrow;
    }
  }
}
