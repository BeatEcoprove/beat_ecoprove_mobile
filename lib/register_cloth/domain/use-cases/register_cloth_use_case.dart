import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/register_cloth/contracts/register_cloth_request.dart';

class RegisterClothUseCase implements UseCase<RegisterClothRequest, Future> {
  final ClosetService _closetService;

  RegisterClothUseCase(this._closetService);

  @override
  Future handle(RegisterClothRequest request) async {
    try {
      await _closetService.registerCloth(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
