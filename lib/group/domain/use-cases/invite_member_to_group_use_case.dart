import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
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
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
