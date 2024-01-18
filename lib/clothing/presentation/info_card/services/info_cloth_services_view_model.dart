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
        backgroundColor: Colors.white,
        title: "Cesto",
        idText: "bucket",
        content: const SvgImage(
          path: "assets/services/bucket.svg",
          height: 30,
          width: 30,
          color: AppColor.buttonBackground,
        ),
        services: {
          "Em que cesto pretende adicionar esta peça?": [
            ServiceItem(
              foregroundColor: AppColor.buttonBackground,
              backgroundColor: Colors.white,
              title: "Novo cesto",
              idText: "bucket_new_bucket",
              content: const Icon(
                Icons.add,
                size: 50,
                color: AppColor.buttonBackground,
              ),
              action: () {},
            ),
          ]
        },
      ),
      ...result,
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        title: "Enviar para reciclagem",
        idText: "recycle",
        backgroundColor: Colors.white,
        content: const SvgImage(
          path: "assets/services/recycle.svg",
          height: 50,
          width: 50,
          color: AppColor.buttonBackground,
        ),
        action: () {},
      ),
      ServiceItem(
        foregroundColor: AppColor.buttonBackground,
        title: "Colocar no lixo",
        idText: "trash",
        backgroundColor: Colors.white,
        content: const SvgImage(
          path: "assets/services/trash.svg",
          height: 50,
          width: 50,
          color: AppColor.buttonBackground,
        ),
        action: () {},
      )
    ];
  }
}
