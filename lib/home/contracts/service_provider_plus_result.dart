import 'package:beat_ecoprove/home/contracts/service_provider_result.dart';

class ServiceProviderPlusResult extends ServiceProviderResult {
  final List<dynamic> services;
  final double rating;

  ServiceProviderPlusResult(
    super.id,
    super.name,
    super.type,
    super.icon,
    this.services,
    this.rating,
  );

  factory ServiceProviderPlusResult.fromJson(Map<String, dynamic> json) {
    dynamic totalRating = json['totalRanking'];
    if (totalRating is int) {
      totalRating = totalRating.toDouble();
    }

    return ServiceProviderPlusResult(
      json['id'],
      json['title'],
      json['type'],
      json['picture'],
      json['services'],
      totalRating,
    );
  }
}
