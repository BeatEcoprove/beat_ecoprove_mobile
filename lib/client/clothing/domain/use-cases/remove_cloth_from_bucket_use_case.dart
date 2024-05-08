import 'package:beat_ecoprove/client/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class RemoveClothFromBucketUseCase
    implements UseCase<RemoveClothFromBucketRequest, Future> {
  final ClosetService _closetService;

  RemoveClothFromBucketUseCase(this._closetService);

  @override
  Future handle(RemoveClothFromBucketRequest request) async {
    try {
      await _closetService.removeClothFromBucket(request);
    } catch (e) {
      rethrow;
    }
  }
}
