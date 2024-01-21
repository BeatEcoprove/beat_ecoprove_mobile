import 'package:beat_ecoprove/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/clothing/services/closet_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
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
    } on HttpError catch (e) {
      print(e);
      throw Exception(e.getError().title);
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
