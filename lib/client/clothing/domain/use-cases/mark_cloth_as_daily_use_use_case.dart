import 'package:beat_ecoprove/client/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class MarkClothAsDailyUseUseCase implements UseCase<List<String>, Future> {
  final OutfitService _outfitService;

  MarkClothAsDailyUseUseCase(this._outfitService);

  @override
  Future handle(List<String> request) async {
    try {
      await _outfitService.markClothAsInUse(request);
    } catch (e) {
      rethrow;
    }
  }
}
