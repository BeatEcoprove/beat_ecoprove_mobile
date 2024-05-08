import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/update_group_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class UpdateGroupUseCase implements UseCase<UpdateGroupRequest, Future> {
  final GroupService _groupService;

  UpdateGroupUseCase(this._groupService);

  @override
  Future handle(UpdateGroupRequest request) async {
    try {
      await _groupService.updateGroup(request);
    } catch (e) {
      rethrow;
    }
  }
}
