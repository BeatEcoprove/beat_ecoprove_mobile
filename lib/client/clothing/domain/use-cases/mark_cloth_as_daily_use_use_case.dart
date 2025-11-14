import 'package:beat_ecoprove/client/clothing/contracts/mark_cloth_in_use_request.dart';
import 'package:beat_ecoprove/client/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class MarkClothAsDailyUseUseCase
    implements UseCase<MarkClothAsDailyUseRequest, Future> {
  final OutfitService _outfitService;

  MarkClothAsDailyUseUseCase(this._outfitService);

  @override
  Future handle(MarkClothAsDailyUseRequest request) async {
    try {
      await _outfitService.markClothAsInUse(request);
    } catch (e) {
      rethrow;
    }
  }
}
