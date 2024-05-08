import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/client/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class GetBucketsUseCase implements UseCaseAction<Future<Map<String, String>>> {
  final ClosetService _clothingService;

  GetBucketsUseCase(this._clothingService);

  @override
  Future<Map<String, String>> handle() async {
    List<BucketResult> buckets = [];
    Map<String, String> bucketData = {};

    try {
      ClosetResult closet = await _clothingService.getBuckets();

      buckets = closet.buckets;
    } catch (e) {
      rethrow;
    }

    for (var bucket in buckets) {
      if (bucket.id == "outfit") {
        continue;
      }

      bucketData.addAll({bucket.id: bucket.name});
    }

    return bucketData;
  }
}
