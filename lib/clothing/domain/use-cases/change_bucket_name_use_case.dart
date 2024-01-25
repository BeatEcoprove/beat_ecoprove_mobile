import 'package:beat_ecoprove/clothing/contracts/change_bucket_name_request.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class ChangeBucketNameUseCase
    implements UseCase<ChangeBucketNameRequest, Future> {
  final ClosetService _closetService;

  ChangeBucketNameUseCase(this._closetService);

  @override
  Future handle(ChangeBucketNameRequest request) async {
    try {
      await _closetService.changeBucketName(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
