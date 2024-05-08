import 'package:beat_ecoprove/client/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class AddClothsBucketUseCase
    implements UseCase<AddClothsBucketRequest, Future> {
  final ClosetService _closetService;

  AddClothsBucketUseCase(this._closetService);

  @override
  Future handle(AddClothsBucketRequest request) async {
    try {
      await _closetService.addClothToBucket(request);
    } catch (e) {
      rethrow;
    }
  }
}
