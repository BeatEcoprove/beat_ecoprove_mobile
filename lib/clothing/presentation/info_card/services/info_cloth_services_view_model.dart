import 'package:beat_ecoprove/clothing/contracts/finish_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/clothing/contracts/make_maintenance_on_cloth_request.dart';
import 'package:beat_ecoprove/clothing/domain/models/service_state.dart';
import 'package:beat_ecoprove/clothing/services/action_service.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class InfoClothServiceViewModel extends ViewModel {
  late List<String> _selectedServices = [];
  final List<String> _blockedServices = [];
  final List<ServiceTemplate> _services = [];

  final ActionService _actionService;
  late String clothId;
  late String activityId;

  InfoClothServiceViewModel(this._actionService);

  bool get haveServicesSelected => _selectedServices.isNotEmpty;

  Future fetchServices(String clothId) async {
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
      _services.addAll(formatServices(services));
    } catch (e) {
      print(e);
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
    }

    notifyListeners();
  }

  List<ServiceTemplate> formatServices(List<Service<dynamic>> result) {
    return [
      Service(
        foregroundColor: AppColor.buttonBackground,
        borderColor: AppColor.widgetBackground,
        backgroundColor: AppColor.widgetBackground,
        title: "Cesto",
        idText: "bucket",
        content: const SvgImage(
          path: "assets/services/bucket.svg",
          height: 20,
          width: 20,
          color: AppColor.buttonBackground,
        ),
        services: {
          "Em que cesto pretende adicionar esta peça?": [
            ServiceItem(
              foregroundColor: AppColor.buttonBackground,
              borderColor: AppColor.widgetBackground,
              backgroundColor: AppColor.widgetBackground,
              title: "Novo cesto",
              idText: "bucket_new_bucket",
              content: const Icon(
                Icons.add,
                size: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
            //TODO: MAKE APPEAR OTHERS BUCKETS AND MAKE POSSIBLE TO PUT CLOTH INSIDE THEM
          ]
        },
      ),
      ...result,
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        borderColor: AppColor.widgetBackground,
        title: "Enviar para reciclagem",
        idText: "recycle",
        backgroundColor: AppColor.widgetBackground,
        content: const SvgImage(
          path: "assets/services/recycle.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        action: () {},
      ),
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        borderColor: AppColor.widgetBackground,
        title: "Colocar no lixo",
        idText: "trash",
        backgroundColor: AppColor.widgetBackground,
        content: const SvgImage(
          path: "assets/services/trash.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        action: () {},
      )
    ];
  }
}
