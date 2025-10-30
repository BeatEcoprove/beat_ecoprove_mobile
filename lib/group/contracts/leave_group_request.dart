import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class LeaveGroupRequest implements BaseJsonRequest {
  final String memberId;
  final String groupId;

  LeaveGroupRequest(
    this.memberId,
    this.groupId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {'member_id': memberId};
  }
}
