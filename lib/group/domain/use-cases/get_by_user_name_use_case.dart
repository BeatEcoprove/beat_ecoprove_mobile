import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class GetByUserNameUseCase implements UseCase<String, Future<ProfileResult>> {
  final ProfileService _profileService;

  GetByUserNameUseCase(this._profileService);

  @override
  Future<ProfileResult> handle(String request) async {
    ProfileResult profile;
    try {
      profile = await _profileService.getByUserName(request);
    } catch (e) {
      rethrow;
    }
    return profile;
  }
}
