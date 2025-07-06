import 'package:beat_ecoprove/client/clothing/contracts/register_brand_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class CreateBrandUseCase implements UseCase<RegisterBrandRequest, Future> {
  final ClosetService _closetService;

  CreateBrandUseCase(this._closetService);

  @override
  Future<void> handle(RegisterBrandRequest request) async {
    try {
      await _closetService.registerBrand(request);
    } catch (e) {
      rethrow;
    }
  }
}
