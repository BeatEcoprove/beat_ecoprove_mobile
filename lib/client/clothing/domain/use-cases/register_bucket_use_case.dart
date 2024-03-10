import 'package:beat_ecoprove/client/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_conflict_request_error.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class RegisterBucketUseCase implements UseCase<RegisterBucketRequest, Future> {
  final ClosetService _closetService;

  RegisterBucketUseCase(this._closetService);

  @override
  Future handle(RegisterBucketRequest request) async {
    try {
      await _closetService.registerBucket(request);
    } on HttpConflictRequestError catch (e) {
      print(e);
      throw Exception(e.getError().title);
    } catch (e) {
      print(e);
      throw Exception("Algo correu mal!");
    }
  }
}
