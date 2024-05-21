import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/remove_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/add_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_store_workers_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/worker.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class StoreWorkersViewModel extends FormViewModel {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;
  final GetStoreWorkersUseCase _getStoreWorkersUseCase;
  final StoreService _storeService;

  late final User? user;
  final List<Worker> workers = [];
  final List<String> types = ["Regular", "Gerente"];

  StoreWorkersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
    this._getStoreWorkersUseCase,
    this._storeService,
  ) {
    initializeFields([
      FormFieldValues.code,
    ]);
    user = _authProvider.appUser;
    setValue(FormFieldValues.code, types.firstOrNull);
  }

  Future getWorkers(String storeId) async {
    try {
      workers.clear();

      var workersResult = await _getStoreWorkersUseCase.handle(
        GetStoreWorkersUseCaseRequest(
          storeId: storeId,
        ),
      );

      workers.addAll(workersResult);
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future addWorker(StoreParams store) async {
    await _navigationRouter.pushAsync(
      StoreRoutes.addWorker(store.storeId),
      extras: store,
    );

    notifyListeners();
  }

  Future removeWorker(String storeId, String workerId) async {
    try {
      await _storeService.removeWorker(RemoveWorkerRequest(storeId, workerId));
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future changeWorkerType(String storeId, String workerId, String type) async {
    try {
      await _storeService.changeWorkerType(
        AddWorkerRequest(storeId, workerId, type),
      );
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
