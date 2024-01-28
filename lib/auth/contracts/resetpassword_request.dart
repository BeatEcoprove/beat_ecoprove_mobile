import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class ResetPasswordRequest implements BaseJsonRequest {
  final String code;
  final String password;

  ResetPasswordRequest(
    this.code,
    this.password,
  );

  @override
  Map<String, dynamic> toJson() {
    return {"password": password};
  }
}
