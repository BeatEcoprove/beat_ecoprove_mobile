import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';

class ClosetResult {
  final List<ClothResult> cloths;
  final List<BucketResult> buckets;

  ClosetResult(
    this.cloths,
    this.buckets,
  );

  factory ClosetResult.fromJson(Map<String, dynamic> json) {
    return ClosetResult(
      _convertJsonToClothResult(json['cloths']),
      _convertJsonToBucketResult(json['buckets']),
    );
  }

  static List<ClothResult> _convertJsonToClothResult(List<dynamic> cloths) {
    var cloth = cloths.map((item) {
      return ClothResult.fromJson(item);
    }).toList();
    return cloth;
  }

  static List<BucketResult> _convertJsonToBucketResult(List<dynamic> buckets) {
    return buckets.map((item) {
      return BucketResult.fromJson(item);
    }).toList();
  }
}
