import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/client/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/finish_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/make_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/domain/models/service_state.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/get_buckets_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/client/clothing/domain/value_objects/bucket_name.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoClothServiceViewModel extends FormViewModel implements Clone {
  final IBucketInfoManager _bucketInfoManager;
  final NotificationProvider _notificationProvider;
  late List<String> _selectedServices = [];
  final List<String> _blockedServices = [];
  final List<ServiceTemplate> _services = [];
  final Map<String, String> _buckets = {};
  final GetBucketsUseCase _getBucketsUseCase;
  final AddClothsBucketUseCase _addClothsBucketUseCase;
  final RegisterBucketUseCase _registerBucketUseCase;
  final INavigationManager _navigationRouter;

  late bool isLoading = false;

  final ActionService _actionService;
  final ClosetService _closetService;
  late List<String> clothId;
  late String activityId;

  InfoClothServiceViewModel(
    this._bucketInfoManager,
    this._notificationProvider,
    this._navigationRouter,
    this._actionService,
    this._closetService,
    this._getBucketsUseCase,
    this._addClothsBucketUseCase,
    this._registerBucketUseCase,
  ) {
    initializeFields([
      FormFieldValues.name,
    ]);
  }

  @override
  void initSync() async {
    if (arg != null) {
      await fetchServices(arg.card.id, false);
    }
  }

  Map<String, String> get getBuckets => _buckets;

  void setName(String name) {
    try {
      setValue<String>(
          FormFieldValues.name, BucketName.create(name).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  bool get haveServicesSelected => _selectedServices.isNotEmpty;

  Future fetchServices(String cardId, bool isBucket) async {
    await fetchBuckets();

    if (isBucket) {
      await fetchBucketServices(cardId);
    } else {
      await fetchClothServices(cardId);
    }

    notifyListeners();
  }

  Future fetchBucketServices(String bucketId) async {
    List<Service<dynamic>> services = [];

    try {
      var availableServices = await _actionService.getAllServices();
      services.addAll(
          availableServices.map((e) => e.toService(handleAction)).toList());

      var bucket = await _closetService.getBucket(bucketId);

      for (var cloth in bucket.associatedCloth
          .where((element) =>
              !_bucketInfoManager.getAllClothes().contains(element.id))
          .toList()) {
        try {
          var result = await _actionService.getCurrentServiceActivity(cloth.id);
          if (result.status != 'Finished') {
            _blockedServices.add(cloth.id);
            _notificationProvider.showNotification(
              'Tem pelo menos uma peça de roupa numa atividade!',
              type: NotificationTypes.warning,
            );
          }
        } on HttpBadRequestError catch (e) {
          _notificationProvider.showNotification(
            e.getError().title,
            type: NotificationTypes.error,
          );
        } catch (e) {
          print(e);
        }

        if (cloth.state == ClothStates.inUse.value) {
          _blockedServices.add(cloth.id);
          _notificationProvider.showNotification(
            'Tem pelo menos uma peça de roupa em uso!',
            type: NotificationTypes.warning,
          );
        }
      }

      _services.clear();
      _services.addAll(
        services,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }
  }

  Future fetchClothServices(String clothId) async {
    List<Service<dynamic>> services = [];

    try {
      var availableServices =
          await _actionService.getClothAvailableServices(clothId);

      if (availableServices.isNotEmpty) {
        services.addAll(
            availableServices.map((e) => e.toService(handleAction)).toList());
      } else {
        var currentRunningServices =
            await _actionService.getCurrentServiceActivity(clothId);

        activityId = currentRunningServices.maintenanceActivityId;
        services.add(currentRunningServices.service.toService(handleAction));
      }

      _services.clear();
      _services.addAll(
        services,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }
  }

  void changeServiceSelection(List<String> services) {
    _selectedServices = services;

    notifyListeners();
  }

  List<String> blockedServices() {
    return _blockedServices;
  }

  List<ServiceTemplate> getAllServices() {
    return _services;
  }

  Future handleAction(String serviceId, String actionId, String state) async {
    try {
      switch (state) {
        case ServiceState.available:
          for (var cloth in clothId) {
            await _actionService.makeMaintenanceOnCloth(
                MakeMaintenanceOnClothRequest(cloth, serviceId, actionId));
          }

          _notificationProvider.showNotification(
            "Ação registada!",
            type: NotificationTypes.success,
          );
          break;
        case ServiceState.running:
          if (activityId.isEmpty) throw Exception("Activity id is empty");

          for (var cloth in clothId) {
            await _actionService.finishMaintenanceOnCLoth(
                FinishMaintenanceOnClothRequest(cloth, activityId));
          }

          _notificationProvider.showNotification(
            "Ação desmarcada!",
            type: NotificationTypes.success,
          );
          break;
      }
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    _navigationRouter.pop();
    notifyListeners();
  }

  Future fetchBuckets() async {
    Map<String, String> buckets = {};

    try {
      buckets = await _getBucketsUseCase.handle();
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    _buckets.addAll(buckets);
  }

  Future registerBucket(String cardId) async {
    isLoading = true;

    var name = getValue(FormFieldValues.name).value ?? "";

    try {
      await _registerBucketUseCase.handle(RegisterBucketRequest(
        name,
        [cardId],
      ));

      _notificationProvider.showNotification(
        "Cesto criado!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    isLoading = false;
    _navigationRouter.pop();
    notifyListeners();
  }

  Future addToBucket(String bucketId, String clothId) async {
    isLoading = true;

    try {
      await _addClothsBucketUseCase.handle(AddClothsBucketRequest(
        bucketId,
        [clothId],
      ));

      _notificationProvider.showNotification(
        "Peça/s adicionada/s ao cesto com sucesso!",
        type: NotificationTypes.success,
      );
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
    }

    isLoading = false;
    _navigationRouter.pop();
    notifyListeners();
  }

  @override
  clone() {
    var clone = InfoClothServiceViewModel(
      _bucketInfoManager,
      _notificationProvider,
      _navigationRouter,
      _actionService,
      _closetService,
      _getBucketsUseCase,
      _addClothsBucketUseCase,
      _registerBucketUseCase,
    );

    return clone;
  }
}
