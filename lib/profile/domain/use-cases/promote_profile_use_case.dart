import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/profile/contracts/promote_profile_request.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';

class PromoteProfileUseCase implements UseCase<PromoteProfileRequest, Future> {
  final ProfileService _profileService;

  PromoteProfileUseCase(this._profileService);

  @override
  Future handle(PromoteProfileRequest profile) async {
    try {
      await _profileService.promoteNestedProfile(profile);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }
  }
}
