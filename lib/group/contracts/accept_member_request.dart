import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class InviteTokenRequest implements BaseJsonRequest {
  final String token;

  InviteTokenRequest(
    this.token,
  );

  @override
  Map<String, dynamic> toJson() {
    return {"token": token};
  }
}
