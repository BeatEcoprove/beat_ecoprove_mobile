import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/invite_member_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class InviteMemberToGroupUseCase
    implements UseCase<InviteMemberRequest, Future> {
  final GroupService _groupService;

  InviteMemberToGroupUseCase(this._groupService);

  @override
  Future handle(InviteMemberRequest request) async {
    try {
      await _groupService.inviteMember(request);
    } catch (e) {
      rethrow;
    }
  }
}
