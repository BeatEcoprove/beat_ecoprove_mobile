import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/get_out_group_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class PromoteMemberUseCase
    implements UseCase<ActionToMemberOfGroupRequest, Future> {
  final GroupService _groupService;

  PromoteMemberUseCase(this._groupService);

  @override
  Future handle(ActionToMemberOfGroupRequest request) async {
    try {
      await _groupService.promoteMember(request);
    } catch (e) {
      rethrow;
    }
  }
}
