import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';

class DeleteProfileUseCase implements UseCase<String, Future> {
  final ProfileService _profileService;

  DeleteProfileUseCase(this._profileService);

  @override
  Future handle(String profileId) async {
    try {
      await _profileService.removeNestedProfile(profileId);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
