import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/worker_result.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/worker.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class GetStoreWorkersUseCaseRequest {
  final int page;
  final int pageSize;
  final String storeId;

  GetStoreWorkersUseCaseRequest({
    this.page = 1,
    this.pageSize = 10,
    required this.storeId,
  });
}

class GetStoreWorkersUseCase
    implements UseCase<GetStoreWorkersUseCaseRequest, Future<List<Worker>>> {
  final StoreService _storeService;

  GetStoreWorkersUseCase(this._storeService);

  @override
  Future<List<Worker>> handle(request) async {
    List<WorkerResult> workerResult;
    List<Worker> workers = [];

    try {
      workerResult = await _storeService.getStoreWorkers(
        request.storeId,
        page: request.page,
        pageSize: request.pageSize,
      );
    } catch (e) {
      rethrow;
    }

    for (var worker in workerResult) {
      var workerCard = Worker(
        id: worker.id,
        name: worker.name,
        email: worker.email,
        type: worker.type,
      );

      workers.add(workerCard);
    }

    return workers;
  }
}
