import 'package:beat_ecoprove/client/clothing/contracts/bucket_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/service_provider/orders/contracts/service_type_result.dart';

class OrderClothResult extends OrderResult {
  final ClothResult cloth;

  OrderClothResult(
    super.orderId,
    super.ownerId,
    super.username,
    super.avatarPicture,
    super.services,
    this.cloth,
  );

  factory OrderClothResult.fromJson(Map<String, dynamic> json) {
    return OrderClothResult(
      json['id'],
      json['owner']['id'],
      json['owner']['username'],
      json['owner']['avatarUrl'],
      _convertJsonToServiceTypeResult(json['services']),
      ClothResult.fromJson(json['cloth']),
    );
  }

  static List<ServiceTypeResult> _convertJsonToServiceTypeResult(
      List<dynamic> services) {
    var service = services.map((item) {
      return ServiceTypeResult.fromJson(item);
    }).toList();
    return service;
  }
}

class OrderBucketResult extends OrderResult {
  final BucketResult bucket;

  OrderBucketResult(
    super.orderId,
    super.ownerId,
    super.username,
    super.avatarPicture,
    super.services,
    this.bucket,
  );

  factory OrderBucketResult.fromJson(Map<String, dynamic> json) {
    return OrderBucketResult(
      json['id'],
      json['owner']['id'],
      json['owner']['username'],
      json['owner']['avatarUrl'],
      _convertJsonToServiceTypeResult(json['services']),
      BucketResult.fromJson(json['bucket']),
    );
  }

  static List<ServiceTypeResult> _convertJsonToServiceTypeResult(
      List<dynamic> services) {
    var service = services.map((item) {
      return ServiceTypeResult.fromJson(item);
    }).toList();
    return service;
  }
}

class OrderResult {
  final String orderId;
  final String ownerId;
  final String username;
  final String avatarPicture;
  final List<ServiceTypeResult> services;

  OrderResult(
    this.orderId,
    this.ownerId,
    this.username,
    this.avatarPicture,
    this.services,
  );

  factory OrderResult.fromJson(Map<String, dynamic> json) {
    switch (json['orderType']) {
      case "ordercloth":
        var result = OrderClothResult.fromJson(json);

        return result;
      case "orderbucket":
        var result = OrderBucketResult.fromJson(json);

        return result;
      default:
        var result = OrderClothResult.fromJson(json);

        return result;
    }
  }
}
