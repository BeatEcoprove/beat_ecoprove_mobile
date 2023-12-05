import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';

class BucketResult {
  final String id;
  final String name;
  final List<ClothResult> associatedCloth;

  BucketResult(
    this.id,
    this.name,
    this.associatedCloth,
  );

  factory BucketResult.fromJson(Map<String, dynamic> json) {
    return BucketResult(
      json['id'],
      json['name'],
      _convertJsonToClothResult(json['associatedCloth']),
    );
  }

  static List<ClothResult> _convertJsonToClothResult(List<dynamic> cloths) {
    return cloths.map((item) {
      return ClothResult.fromJson(item);
    }).toList();
  }
}
