import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/current_service_result.dart';

class GetCurrentMaintenanceActionRequest {
  final ClothResult cloth;
  final CurrentServiceResult service;
  final String maintenanceActivityId;
  final ServiceStates status;

  GetCurrentMaintenanceActionRequest(
      this.cloth, this.service, this.maintenanceActivityId, this.status);

  factory GetCurrentMaintenanceActionRequest.fromJson(
      Map<String, dynamic> json) {
    return GetCurrentMaintenanceActionRequest(
      ClothResult.fromJson(json['cloth']),
      CurrentServiceResult.fromJson(json['service']),
      json['maintenanceActivityId'],
      ServiceStates.getOf(json['status']),
    );
  }
}

enum ServiceStates implements Comparable<ServiceStates> {
  running(value: "Running"),
  finish(value: "Finished");

  final String value;

  const ServiceStates({required this.value});

  static ServiceStates getOf(String value) =>
      ServiceStates.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return ServiceStates.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ServiceStates other) {
    throw UnimplementedError();
  }
}
