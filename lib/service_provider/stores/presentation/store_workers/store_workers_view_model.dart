import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/change_worker_permission_request.dart';
import 'package:beat_ecoprove/service_provider/stores/contracts/remove_worker_request.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/get_store_workers_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/worker.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/use-cases/remove_worker_use_case.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/store_params.dart';
import 'package:beat_ecoprove/service_provider/stores/routes.dart';
import 'package:beat_ecoprove/service_provider/stores/services/store_service.dart';

class StoreWorkersViewModel extends FormViewModel<StoreParams>
    implements Clone {
  final INotificationProvider _notificationProvider;
  final AuthenticationProvider _authProvider;
  final INavigationManager _navigationRouter;
  final GetStoreWorkersUseCase _getStoreWorkersUseCase;
  final RemoveWorkerUseCase _removeWorkerUseCase;
  final StoreService _storeService;

  late final User? user;
  final List<Worker> workers = [];
  final List<String> types = [];

  late String _storeId = '';

  StoreWorkersViewModel(
    this._notificationProvider,
    this._authProvider,
    this._navigationRouter,
    this._getStoreWorkersUseCase,
    this._removeWorkerUseCase,
    this._storeService,
  ) {
    var employeeTypes = EmployeeType.getAllTypes().map((e) => e.text);
    types.addAll(employeeTypes);

    initializeFields([
      FormFieldValues.code,
    ]);
    user = _authProvider.appUser;
    setValue(FormFieldValues.code, EmployeeType.getAllTypes().first.text);
  }

  @override
  void initSync() async {
    if (arg == null) return;

    _storeId = arg!.storeId;
    await getWorkers(_storeId);
  }

  Future getWorkers(String storeId) async {
    try {
      var workersResult = await _getStoreWorkersUseCase.handle(
        GetStoreWorkersUseCaseRequest(
          storeId: storeId,
        ),
      );

      workers.clear();
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
      await _removeWorkerUseCase.handle(RemoveWorkerRequest(storeId, workerId));

      _notificationProvider.showNotification(
        "Funcionário removido!",
        type: NotificationTypes.success,
      );

      _navigationRouter.pop();
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future changeWorkerType(String storeId, String workerId, String type) async {
    try {
      await _storeService.changeWorkerType(
        ChangeWorkerPermissionRequest(
            storeId, workerId, EmployeeType.getValue(type)),
      );

      _notificationProvider.showNotification(
        "Permissão alterada!",
        type: NotificationTypes.success,
      );

      notifyListeners();
    } on HttpError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  bool hasAuthorization() =>
      user is! Employee ||
      user is Employee && (user as Employee).workerType != EmployeeType.worker;

  @override
  StoreWorkersViewModel clone() {
    return StoreWorkersViewModel(
      _notificationProvider,
      _authProvider,
      _navigationRouter,
      _getStoreWorkersUseCase,
      _removeWorkerUseCase,
      _storeService,
    );
  }
}
