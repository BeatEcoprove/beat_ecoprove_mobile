import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
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
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
