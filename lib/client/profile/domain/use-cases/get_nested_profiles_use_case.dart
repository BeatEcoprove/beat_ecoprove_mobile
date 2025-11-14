import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class GetNestedProfilesUseCase
    implements UseCaseAction<Future<ProfilesResult>> {
  final ProfileService _profileService;

  GetNestedProfilesUseCase(this._profileService);

  @override
  Future<ProfilesResult> handle() async {
    ProfilesResult profiles;

    try {
      //FIXME: WAITING FOR BACKEND IMPLEMENTATION
      //TODO: Change later, page, pageSize e search
      profiles = ProfilesResult([]);
      // await _profileService.getAllProfiles(1, 1000);
    } catch (e) {
      rethrow;
    }

    return profiles;
  }
}
