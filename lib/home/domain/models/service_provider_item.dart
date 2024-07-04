import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';

class ServiceProviderItem {
  final String id;
  final String name;
  final String type;
  final String? picture;
  final String icon;
  final double? rating;
  final List<IconButtonRetangularType>? services;

  ServiceProviderItem({
    required this.id,
    required this.name,
    required this.type,
    this.picture,
    required this.icon,
    this.rating,
    this.services,
  });
}
