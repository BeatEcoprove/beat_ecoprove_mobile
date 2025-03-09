import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class HistoryActionRequest implements BaseJsonRequest {
  final String clothId;
  final Map<String, String> params;
  final int page;
  final int pageSize;

  HistoryActionRequest(
    this.clothId, {
    Map<String, String>? params,
    this.page = 1,
    this.pageSize = 10,
  }) : params = params ?? {};

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
