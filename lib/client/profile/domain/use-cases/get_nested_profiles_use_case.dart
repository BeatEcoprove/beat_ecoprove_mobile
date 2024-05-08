import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class GetNestedProfilesUseCase
    implements UseCaseAction<Future<NestedProfilesResult>> {
  final ProfileService _profileService;

  GetNestedProfilesUseCase(this._profileService);

  @override
  Future<NestedProfilesResult> handle() async {
    NestedProfilesResult profiles;

    try {
      profiles = await _profileService.getNestedProfiles();
    } catch (e) {
      rethrow;
    }

    return profiles;
  }
}
