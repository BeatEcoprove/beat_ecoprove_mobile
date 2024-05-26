import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class RemoveAdvertRequest implements BaseJsonRequest {
  final String advertId;

  RemoveAdvertRequest(
    this.advertId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
