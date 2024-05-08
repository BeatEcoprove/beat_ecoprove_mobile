import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/group_details_result.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class GetDetailsUseCase implements UseCase<String, Future<GroupDetailsResult>> {
  final GroupService _groupService;

  GetDetailsUseCase(this._groupService);

  @override
  Future<GroupDetailsResult> handle(String groupId) async {
    GroupDetailsResult groupDetails;

    try {
      groupDetails = await _groupService.getGroupDetails(groupId);
    } catch (e) {
      rethrow;
    }

    return groupDetails;
  }
}
