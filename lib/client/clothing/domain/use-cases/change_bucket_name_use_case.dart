import 'package:beat_ecoprove/client/clothing/contracts/change_bucket_name_request.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class ChangeBucketNameUseCase
    implements UseCase<ChangeBucketNameRequest, Future> {
  final ClosetService _closetService;

  ChangeBucketNameUseCase(this._closetService);

  @override
  Future handle(ChangeBucketNameRequest request) async {
    try {
      await _closetService.changeBucketName(request);
    } catch (e) {
      rethrow;
    }
  }
}
