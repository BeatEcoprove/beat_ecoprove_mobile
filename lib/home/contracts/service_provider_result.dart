import 'package:beat_ecoprove/service_provider/stores/contracts/store_result.dart';

class ServiceProviderResult {
  final String id;
  final String name;
  final String type;
  final String picture;
  final String icon;
  final double rating;
  final List<StoreResult> stores;

  ServiceProviderResult(
    this.id,
    this.name,
    this.type,
    this.picture,
    this.icon,
    this.rating,
    this.stores,
  );

  factory ServiceProviderResult.fromJson(Map<String, dynamic> json) {
    dynamic totalRating = json['totalRating'];
    if (totalRating is int) {
      totalRating = totalRating.toDouble();
    }

    return ServiceProviderResult(
      json['id'],
      json['name'],
      json['type'],
      json['picture'],
      json['icon'],
      totalRating,
      json['stores'],
    );
  }
}
