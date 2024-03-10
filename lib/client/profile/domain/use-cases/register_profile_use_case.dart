import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/register_profile_request.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class RegisterProfileUseCase
    implements UseCase<RegisterProfileRequest, Future> {
  final ProfileService _profileService;

  RegisterProfileUseCase(this._profileService);

  @override
  Future handle(RegisterProfileRequest request) async {
    try {
      await _profileService.registerProfile(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
