import 'package:beat_ecoprove/client/clothing/contracts/add_cloths_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class AddClothsBucketUseCase
    implements UseCase<AddClothsBucketRequest, Future> {
  final ClosetService _closetService;

  AddClothsBucketUseCase(this._closetService);

  @override
  Future handle(AddClothsBucketRequest request) async {
    try {
      await _closetService.addClothToBucket(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
