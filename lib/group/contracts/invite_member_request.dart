import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';

class InviteMemberRequest implements BaseJsonRequest {
  final String memberId;
  final String groupId;

  InviteMemberRequest(
    this.memberId,
    this.groupId,
  );

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
