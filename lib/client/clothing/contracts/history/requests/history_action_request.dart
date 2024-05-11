import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class HistoryActionRequest implements BaseJsonRequest {
  final String clothId;

  HistoryActionRequest(
    this.clothId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
