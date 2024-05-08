import 'package:beat_ecoprove/client/clothing/contracts/register_bucket_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class RegisterBucketUseCase implements UseCase<RegisterBucketRequest, Future> {
  final ClosetService _closetService;

  RegisterBucketUseCase(this._closetService);

  @override
  Future handle(RegisterBucketRequest request) async {
    try {
      await _closetService.registerBucket(request);
    } catch (e) {
      rethrow;
    }
  }
}
