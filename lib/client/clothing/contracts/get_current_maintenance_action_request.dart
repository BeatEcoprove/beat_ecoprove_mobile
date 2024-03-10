import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/current_service_result.dart';

class GetCurrentMaintenanceActionRequest {
  final ClothResult cloth;
  final CurrentServiceResult service;
  final String maintenanceActivityId;
  final String status;

  GetCurrentMaintenanceActionRequest(
      this.cloth, this.service, this.maintenanceActivityId, this.status);

  factory GetCurrentMaintenanceActionRequest.fromJson(
      Map<String, dynamic> json) {
    return GetCurrentMaintenanceActionRequest(
      ClothResult.fromJson(json['cloth']),
      CurrentServiceResult.fromJson(json['service']),
      json['maintenanceActivityId'],
      json['status'],
    );
  }
}
