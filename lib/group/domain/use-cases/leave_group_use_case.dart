import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/leave_group_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class LeaveGroupUseCase implements UseCase<LeaveGroupRequest, Future> {
  final GroupService _groupService;

  LeaveGroupUseCase(this._groupService);

  @override
  Future handle(LeaveGroupRequest request) async {
    try {
      await _groupService.leaveGroup(request);
    } catch (e) {
      rethrow;
    }
  }
}
