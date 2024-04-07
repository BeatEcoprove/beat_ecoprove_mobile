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
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_service_params.dart';
import 'package:beat_ecoprove/client/clothing/services/action_service.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/view_model.dart';

class InfoClothServiceViewModelAlt extends FormViewModel<InfoClothServiceParms>
    implements Clone {
  final IBucketInfoManager bucketInfoManager;
  final NotificationProvider _notificationProvider;
  final INavigationManager _navigationManager;
  final RegisterBucketUseCase _registerBucketUseCase;
  final AddClothsBucketUseCase _addClothsBucketUseCase;
  final GetBucketsUseCase _getBucketsUseCase;
  final ActionService _actionService;
  final ClosetService _closetService;

  final List<ServiceTemplate> services = [];
  final List<String> selectedServices = [];
  final List<String> blockedServices = [];
  final Map<String, String> buckets = {};
  final Set<String> clothIds = {};

  late String activityId = "";

  InfoClothServiceViewModelAlt(
    this.bucketInfoManager,
    this._notificationProvider,
    this._navigationManager,
    this._registerBucketUseCase,
    this._addClothsBucketUseCase,
    this._getBucketsUseCase,
    this._actionService,
    this._closetService,
  ) {
    initializeFields([
      FormFieldValues.name,
    ]);
  }

  @override
  void initSync() async {
    await fetchBuckets();

    if (arg != null) {
      await refetch();
    }
  }

  get isLoading =>
      services.isNotEmpty || arg?.card.clothState != ClothStates.idle;

  Future refetch() async {
    if (arg!.card.hasChildren) {
      clothIds.addAll(getClothFromBucketManager());
      await fetchBucketServices(arg!.card.id);
    } else {
      if (arg!.card.clothState != ClothStates.idle || arg!.card.hasChildren) {
        return;
      }

      clothIds.addAll([arg!.card.id]);
      await fetchClothServices(arg!.card.id);
    }

    notifyListeners();
  }

  List<String> getClothFromBucketManager() {
    return (arg!.card.child as List<CardItem>)
        .map((card) => card.id)
        .where((e) => !bucketInfoManager.getAllClothes().contains(e))
        .toList();
  }

  Future fetchClothServices(String clothId) async {
    List<Service<dynamic>> result = [];

    try {
      var availableServices =
          await _actionService.getClothAvailableServices(clothId);

      if (availableServices.isNotEmpty) {
        result.addAll(
            availableServices.map((e) => e.toService(handleAction)).toList());
      } else {
        var currentRunningServices =
            await _actionService.getCurrentServiceActivity(clothId);

        activityId = currentRunningServices.maintenanceActivityId;
        result.add(currentRunningServices.service.toService(handleAction));
      }

      services.clear();
      services.addAll(
        result,
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

  Future fetchBucketServices(String bucketId) async {
    List<Service<dynamic>> result = [];
    Map<String, ClothResult> clothStates = {};

    try {
      var availableServices = await _actionService.getAllServices();
      result.addAll(
          availableServices.map((e) => e.toService(handleAction)).toList());

      var bucket = await _closetService.getBucket(bucketId);
      var clothOfBucket = bucket.associatedCloth
          .where((element) =>
              !bucketInfoManager.getAllClothes().contains(element.id))
          .toList();

      if (clothOfBucket.any((cloth) => cloth.clothState == ClothStates.inUse)) {
        _notificationProvider.showNotification(
          "Possuí pelo menos uma roupa em uso",
          type: NotificationTypes.warning,
        );
        return;
      }

      for (var cloth in clothOfBucket) {
        try {
          var result = await _actionService.getCurrentServiceActivity(cloth.id);

          if (result.status == 'Running') {
            clothStates[result.service.id] = result.cloth;
          }
        } on HttpBadRequestError catch (e) {
          _notificationProvider.showNotification(
            e.getError().title,
            type: NotificationTypes.error,
          );
        } catch (e) {
          print(e);
        }
      }

      if (clothStates.length == 1 && result.length > clothStates.length) {
        _notificationProvider.showNotification(
          "Uma ou mais roupas estão em manutênção",
          type: NotificationTypes.warning,
        );
        return;
      }

      services.clear();
      services.addAll(
        result,
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

  Future handleAction(String serviceId, String actionId, String state) async {
    try {
      switch (state) {
        case ServiceState.available:
          for (var cloth in clothIds) {
            await _actionService.makeMaintenanceOnCloth(
              MakeMaintenanceOnClothRequest(cloth, serviceId, actionId),
            );
          }

          _notificationProvider.showNotification(
            "Ação registada!",
            type: NotificationTypes.success,
          );
          break;
        case ServiceState.running:
          if (activityId.isEmpty) throw Exception("Activity id is empty");

          for (var cloth in clothIds) {
            await _actionService.finishMaintenanceOnCLoth(
              FinishMaintenanceOnClothRequest(cloth, activityId),
            );
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

    _navigationManager.pop();
    await refetch();
  }

  void setName(String name) async {
    try {
      setValue<String>(FormFieldValues.name, name);
    } on DomainException catch (e) {
      setError(FormFieldValues.name, e.message);
    }
  }

  Future fetchBuckets() async {
    try {
      var result = await _getBucketsUseCase.handle();

      buckets.clear();
      buckets.addAll(result);
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

    notifyListeners();
  }

  Future registerBucket(String cardId) async {
    var name = getValue(FormFieldValues.name).value ?? "";

    try {
      await _registerBucketUseCase.handle(
        RegisterBucketRequest(
          name,
          [cardId],
        ),
      );

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

    _navigationManager.pop();
    notifyListeners();
  }

  Future addToBucket(String bucketId, String clothId) async {
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

    _navigationManager.pop();
    notifyListeners();
  }

  void changeServiceSelection(List<String> services) {
    selectedServices.clear();
    selectedServices.addAll(services);

    notifyListeners();
  }

  @override
  clone() {
    return InfoClothServiceViewModelAlt(
      bucketInfoManager,
      _notificationProvider,
      _navigationManager,
      _registerBucketUseCase,
      _addClothsBucketUseCase,
      _getBucketsUseCase,
      _actionService,
      _closetService,
    );
  }
}
