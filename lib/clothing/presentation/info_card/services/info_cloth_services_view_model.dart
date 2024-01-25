import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/clothing/contracts/finish_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/clothing/contracts/make_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/clothing/domain/models/service_state.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/add_cloths_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/get_buckets_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/use-cases/register_bucket_use_case.dart';
import 'package:beat_ecoprove/clothing/domain/value_objects/bucket_name.dart';
import 'package:beat_ecoprove/clothing/services/action_service.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfoClothServiceViewModel extends FormViewModel {
  final NotificationProvider _notificationProvider;
  late List<String> _selectedServices = [];
  final List<String> _blockedServices = [];
  final List<ServiceTemplate> _services = [];
  final Map<String, String> _buckets = {};
  final GetBucketsUseCase _getBucketsUseCase;
  final AddClothsBucketUseCase _addClothsBucketUseCase;
  final RegisterBucketUseCase _registerBucketUseCase;
  final GoRouter _navigationRouter;

  late bool isLoading = false;

  final ActionService _actionService;
  late String clothId;
  late String activityId;

  InfoClothServiceViewModel(
    this._notificationProvider,
    this._navigationRouter,
    this._actionService,
    this._getBucketsUseCase,
    this._addClothsBucketUseCase,
    this._registerBucketUseCase,
  ) {
    initializeFields([FormFieldValues.name]);
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

  Future fetchServices(
      String clothId, bool isBucket, BuildContext context) async {
    List<Service<dynamic>> services = [];

    fetchBuckets();

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
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }
  }

  void changeServiceSelection(List<String> services) {
    _selectedServices = services;

    notifyListeners();
  }

  List<String> blockedServices() {
    return _blockedServices;
  }

  List<ServiceTemplate> get getAllServices => _services;

  void handleAction(String serviceId, String actionId, String state) async {
    try {
      switch (state) {
        case ServiceState.available:
          await _actionService.makeMaintenanceOnCloth(
              MakeMaintenanceOnClothRequest(clothId, serviceId, actionId));
          break;
        case ServiceState.running:
          if (activityId.isEmpty) throw Exception("Activity id is empty");

          await _actionService.finishMaintenanceOnCLoth(
              FinishMaintenanceOnClothRequest(clothId, activityId));
          break;
      }
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Ação registada!",
      type: NotificationTypes.success,
    );

    notifyListeners();
  }

  void fetchBuckets() async {
    Map<String, String> buckets = {};

    try {
      buckets = await _getBucketsUseCase.handle();
    } catch (e) {
      print(e);
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _buckets.addAll(buckets);
  }

  Future registerBucket(String cardId) async {
    isLoading = true;
    notifyListeners();

    var name = getValue(FormFieldValues.name).value ?? "";

    try {
      await _registerBucketUseCase.handle(RegisterBucketRequest(
        name,
        [cardId],
      ));
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Cesto criado!",
      type: NotificationTypes.success,
    );

    isLoading = false;
    _navigationRouter.go('/');
    notifyListeners();
  }

  Future addToBucket(String bucketId, String clothId) async {
    isLoading = true;
    notifyListeners();

    try {
      await _addClothsBucketUseCase.handle(AddClothsBucketRequest(
        bucketId,
        [clothId],
      ));
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    _notificationProvider.showNotification(
      "Peça/s adicionada/s ao cesto com sucesso!",
      type: NotificationTypes.success,
    );

    isLoading = false;
    _navigationRouter.go('/');
    notifyListeners();
  }
}
