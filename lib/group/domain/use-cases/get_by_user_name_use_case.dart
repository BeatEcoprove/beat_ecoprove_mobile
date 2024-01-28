import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';

class GetByUserNameUseCase implements UseCase<String, Future<ProfileResult>> {
  final ProfileService _profileService;

  GetByUserNameUseCase(this._profileService);

  @override
  Future<ProfileResult> handle(String request) async {
    ProfileResult profile;
    try {
      profile = await _profileService.getByUserName(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
    return profile;
  }
}
