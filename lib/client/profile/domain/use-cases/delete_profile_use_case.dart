import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/profile/services/profile_service.dart';

class DeleteProfileUseCase implements UseCase<String, Future> {
  final ProfileService _profileService;

  DeleteProfileUseCase(this._profileService);

  @override
  Future handle(String profileId) async {
    try {
      await _profileService.removeNestedProfile(profileId);
    } catch (e) {
      rethrow;
    }
  }
}
