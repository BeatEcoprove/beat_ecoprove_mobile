import 'package:beat_ecoprove/clothing/services/outfit_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class MarkClothAsDailyUseUseCase implements UseCase<List<String>, Future> {
  final OutfitService _outfitService;

  MarkClothAsDailyUseUseCase(this._outfitService);

  @override
  Future handle(List<String> request) async {
    try {
      await _outfitService.markClothAsInUse(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
