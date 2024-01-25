import 'package:beat_ecoprove/clothing/contracts/remove_cloth_from_bucket_request.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class RemoveClothFromBucketUseCase
    implements UseCase<RemoveClothFromBucketRequest, Future> {
  final ClosetService _closetService;

  RemoveClothFromBucketUseCase(this._closetService);

  @override
  Future handle(RemoveClothFromBucketRequest request) async {
    try {
      await _closetService.removeClothFromBucket(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
