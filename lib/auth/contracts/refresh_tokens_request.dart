import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RefreshTokensRequest implements BaseFormUrlEncodedRequest {
  final String refreshToken;
  final String profileId;

  RefreshTokensRequest({required this.refreshToken, this.profileId = ""});

  @override
  Map<String, String> toFormUrlEncoded() {
    return {"refreshToken": refreshToken, "profileId": profileId};
  }
}
