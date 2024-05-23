import 'package:beat_ecoprove/core/domain/models/card_item.dart';

class OrderItem {
  final String id;
  final String orderId;
  final String ownerId;
  final String username;
  final String avatarPicture;
  final List<CardItem> clothes;
  final List<String> services;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.ownerId,
    required this.username,
    required this.avatarPicture,
    required this.clothes,
    required this.services,
  });
}
