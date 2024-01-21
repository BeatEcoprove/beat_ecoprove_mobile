import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class ActionToMemberOfGroupRequest implements BaseJsonRequest {
  final String memberId;
  final String groupId;

  ActionToMemberOfGroupRequest(
    this.memberId,
    this.groupId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
