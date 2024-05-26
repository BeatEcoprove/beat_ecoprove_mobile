import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/service_provider/profile/contracts/register_advert_request.dart';
import 'package:beat_ecoprove/service_provider/profile/services/adverts_service.dart';

class RegisterAdvertUseCase implements UseCase<RegisterAdvertRequest, Future> {
  final AdvertsService _advertService;

  RegisterAdvertUseCase(this._advertService);

  @override
  Future handle(RegisterAdvertRequest request) async {
    try {
      await _advertService.registerAdvert(request);
    } catch (e) {
      rethrow;
    }
  }
}
