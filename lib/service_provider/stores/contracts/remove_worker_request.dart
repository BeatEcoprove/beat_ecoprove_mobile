import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RemoveWorkerRequest implements BaseJsonRequest {
  final String storeId;
  final String id;

  RemoveWorkerRequest(
    this.storeId,
    this.id,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
