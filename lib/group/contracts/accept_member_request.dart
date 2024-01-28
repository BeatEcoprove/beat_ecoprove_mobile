import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class AcceptMemberOnGroupRequest implements BaseJsonRequest {
  final String groupId;
  final String code;

  AcceptMemberOnGroupRequest(
    this.groupId,
    this.code,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
