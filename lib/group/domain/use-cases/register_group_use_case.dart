import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/group/contracts/register_group_request.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class RegisterGroupUseCase implements UseCase<RegisterGroupRequest, Future> {
  final GroupService _groupService;

  RegisterGroupUseCase(this._groupService);

  @override
  Future handle(RegisterGroupRequest request) async {
    try {
      await _groupService.registerGroup(request);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }
  }
}
