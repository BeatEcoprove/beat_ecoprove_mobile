import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class PromoteProfileRequest implements BaseJsonRequest {
  final String email;
  final String password;
  final String profileId;

  PromoteProfileRequest(
    this.email,
    this.password,
    this.profileId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
