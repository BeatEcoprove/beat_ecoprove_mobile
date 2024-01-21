import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class LeaveGroupUseCase
    implements UseCase<ActionToMemberOfGroupRequest, Future> {
  final GroupService _groupService;

  LeaveGroupUseCase(this._groupService);

  @override
  Future handle(ActionToMemberOfGroupRequest request) async {
    try {
      await _groupService.leaveGroup(request);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }
  }
}
