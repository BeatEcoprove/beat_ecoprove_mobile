import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RefreshTokensRequest implements BaseJsonRequest {
  final String refreshToken;

  RefreshTokensRequest({required this.refreshToken});

  @override
  Map<String, dynamic> toJson() {
    return {"refreshToken": refreshToken};
  }
}
