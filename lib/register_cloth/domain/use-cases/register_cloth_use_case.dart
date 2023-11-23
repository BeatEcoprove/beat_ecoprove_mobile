import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/register_cloth/contracts/register_cloth_request.dart';
import 'package:beat_ecoprove/register_cloth/services/register_cloth_service.dart';

class RegisterClothUseCase implements UseCase<RegisterClothRequest, Future> {
  final RegisterClothService _registerClothService;

  RegisterClothUseCase(this._registerClothService);

  @override
  Future handle(RegisterClothRequest request) async {
    try {
      await _registerClothService.registerCloth(request, request.profileId);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }
  }
}
