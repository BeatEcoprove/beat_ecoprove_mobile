import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class MakeMaintenanceOnClothRequest implements BaseJsonRequest {
  final String clothId;
  final String serviceId;
  final String actionId;

  MakeMaintenanceOnClothRequest(this.clothId, this.serviceId, this.actionId);

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
