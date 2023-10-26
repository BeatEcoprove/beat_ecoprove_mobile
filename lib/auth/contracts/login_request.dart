import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class LoginRequest implements BaseJsonRequest {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);

  @override
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
