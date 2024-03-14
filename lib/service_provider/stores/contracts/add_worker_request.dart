import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class AddWorkerRequest implements BaseJsonRequest {
  final String email;
  final String type;

  AddWorkerRequest(
    this.email,
    this.type,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'type': type,
    };
  }
}
