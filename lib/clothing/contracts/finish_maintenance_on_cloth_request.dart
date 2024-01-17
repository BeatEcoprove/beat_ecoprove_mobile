import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class FinishMaintenanceOnClothRequest implements BaseJsonRequest {
  final String serviceId; 
  final String actionId;

  FinishMaintenanceOnClothRequest(
    this.serviceId, 
    this.actionId
  );
  
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
