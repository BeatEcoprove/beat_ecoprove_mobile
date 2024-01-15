import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';

class GetNestedProfilesUseCase
    implements UseCaseAction<Future<ProfilesResult>> {
  final ProfileService _profileService;

  GetNestedProfilesUseCase(this._profileService);

  @override
  Future<ProfilesResult> handle() async {
    ProfilesResult profiles;

    try {
      profiles = await _profileService.getNestedProfiles();
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }

    return profiles;
  }
}
