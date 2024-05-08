import 'package:beat_ecoprove/client/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class UnMarkClothAsDailyUseUseCase implements UseCase<List<String>, Future> {
  final OutfitService _outfitService;

  UnMarkClothAsDailyUseUseCase(this._outfitService);

  @override
  Future handle(List<String> request) async {
    try {
      await _outfitService.unMarkClothAsInUse(request);
    } catch (e) {
      rethrow;
    }
  }
}
