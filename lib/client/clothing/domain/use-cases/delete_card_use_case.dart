import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class DeleteCardRequest {
  final String cardId;
  final String type;

  DeleteCardRequest({required this.cardId, required this.type});
}

class DeleteCardUseCase implements UseCase<DeleteCardRequest, Future> {
  final ClosetService _closetService;

  DeleteCardUseCase(this._closetService);

  @override
  Future handle(DeleteCardRequest request) async {
    try {
      switch (request.type) {
        case "bucket":
          await _closetService.deleteBucket(request.cardId);
          break;
        case "cloth":
          await _closetService.deleteCloth(request.cardId);
        default:
          break;
      }
    } catch (e) {
      rethrow;
    }
  }
}
