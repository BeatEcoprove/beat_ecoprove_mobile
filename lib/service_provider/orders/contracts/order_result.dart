import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';

class OrderResult {
  final String id;
  final String orderId;
  final String ownerId;
  final String username;
  final String avatarPicture;
  final List<ClothResult> cloths;
  final List<BucketResult> buckets;
  final List<String> services;

  OrderResult(
    this.id,
    this.orderId,
    this.ownerId,
    this.username,
    this.avatarPicture,
    this.cloths,
    this.buckets,
    this.services,
  );

  factory OrderResult.fromJson(Map<String, dynamic> json) {
    var result = OrderResult(
      json['id'],
      json['orderId'],
      json['owner']['id'],
      json['owner']['userName'],
      json['owner']['avatarUrl'],
      _convertJsonToClothResult(json['cloths']),
      _convertJsonToBucketResult(json['buckets']),
      json['services'],
    );

    return result;
  }

  static List<ClothResult> _convertJsonToClothResult(List<dynamic> cloths) {
    var cloth = cloths.map((item) {
      return ClothResult.fromJson(item);
    }).toList();
    return cloth;
  }

  static List<BucketResult> _convertJsonToBucketResult(List<dynamic> buckets) {
    var bucket = buckets.map((item) {
      return BucketResult.fromJson(item);
    }).toList();
    return bucket;
  }
}
