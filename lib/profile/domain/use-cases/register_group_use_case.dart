import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/profile/contracts/register_profile_request.dart';
import 'package:beat_ecoprove/profile/services/profile_service.dart';

class RegisterProfileUseCase
    implements UseCase<RegisterProfileRequest, Future> {
  final ProfileService _profileService;

  RegisterProfileUseCase(this._profileService);

  @override
  Future handle(RegisterProfileRequest request) async {
    try {
      await _profileService.registerProfile(request);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }
  }
}
