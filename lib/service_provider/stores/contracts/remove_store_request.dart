import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RemoveStoreRequest implements BaseJsonRequest {
  final String storeId;

  RemoveStoreRequest(
    this.storeId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
