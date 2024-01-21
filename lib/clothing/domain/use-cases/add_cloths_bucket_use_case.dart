import 'package:beat_ecoprove/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class AddClothsBucketUseCase
    implements UseCase<AddClothsBucketRequest, Future> {
  final ClosetService _closetService;

  AddClothsBucketUseCase(this._closetService);

  @override
  Future handle(AddClothsBucketRequest request) async {
    try {
      await _closetService.addClothToBucket(request);
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    }
  }
}
