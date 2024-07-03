import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class ChangeWorkerPermissionRequest implements BaseJsonRequest {
  final String storeId;
  final String id;
  final String type;

  ChangeWorkerPermissionRequest(
    this.storeId,
    this.id,
    this.type,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}
