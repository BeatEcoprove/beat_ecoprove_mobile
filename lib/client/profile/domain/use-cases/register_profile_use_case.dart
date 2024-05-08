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
    } catch (e) {
      rethrow;
    }
  }
}
