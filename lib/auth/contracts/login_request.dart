import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class LoginRequest implements BaseFormUrlEncodedRequest {
  final String email;
  final String grantType = "password";
  final String password;

  LoginRequest(this.email, this.password);

  @override
  Map<String, String> toFormUrlEncoded() {
    return {
      "email": email,
      "grant_type": grantType,
      "password": password,
    };
  }
}
