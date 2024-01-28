import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class ForgotPasswordRequest implements BaseJsonRequest {
  final String email;

  ForgotPasswordRequest(this.email);

  @override
  Map<String, dynamic> toJson() {
    return {"email": email};
  }
}
