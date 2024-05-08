import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/client/register_cloth/contracts/register_cloth_request.dart';

class RegisterClothUseCase implements UseCase<RegisterClothRequest, Future> {
  final ClosetService _closetService;

  RegisterClothUseCase(this._closetService);

  @override
  Future handle(RegisterClothRequest request) async {
    try {
      await _closetService.registerCloth(request);
    } catch (e) {
      rethrow;
    }
  }
}
