import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/add_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class AddWorkerUseCase implements UseCase<AddWorkerRequest, Future> {
  final StoreService _storeService;

  AddWorkerUseCase(this._storeService);

  @override
  Future handle(AddWorkerRequest request) async {
    try {
      await _storeService.addWorker(request);
    } catch (e) {
      rethrow;
    }
  }
}
