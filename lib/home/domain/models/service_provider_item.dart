import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';

class ServiceProviderItem {
  final String id;
  final String name;
  final String type;
  final String picture;
  final String icon;
  final double rating;
  final List<StoreItem> stores;

  ServiceProviderItem({
    required this.id,
    required this.name,
    required this.type,
    required this.picture,
    required this.icon,
    required this.rating,
    required this.stores,
  });
}
