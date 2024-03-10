import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/promote_profile_request.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class PromoteProfileUseCase implements UseCase<PromoteProfileRequest, Future> {
  final ProfileService _profileService;

  PromoteProfileUseCase(this._profileService);

  @override
  Future handle(PromoteProfileRequest profile) async {
    try {
      await _profileService.promoteNestedProfile(profile);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
