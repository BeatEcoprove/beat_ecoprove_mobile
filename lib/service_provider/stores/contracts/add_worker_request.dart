import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class AddWorkerRequest implements BaseJsonRequest {
  final String storeId;
  final String name;
  final String email;
  final String type;

  AddWorkerRequest(
    this.storeId,
    this.name,
    this.email,
    this.type,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'permission': type,
      'email': email,
      'name': name,
    };
  }
}
