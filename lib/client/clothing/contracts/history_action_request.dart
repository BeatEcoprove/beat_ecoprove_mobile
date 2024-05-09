import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class HistoryActionRequest implements BaseJsonRequest {
  final String profileId;
  final String clothId;

  HistoryActionRequest(
    this.profileId,
    this.clothId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
    };
  }
}
