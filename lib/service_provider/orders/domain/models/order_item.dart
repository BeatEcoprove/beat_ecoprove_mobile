import 'package:beat_ecoprove/core/domain/models/card_item.dart';

class OrderItem {
  final String orderId;
  final String ownerId;
  final String username;
  final String avatarPicture;
  final CardItem card;
  final List<String> services;

  OrderItem({
    required this.orderId,
    required this.ownerId,
    required this.username,
    required this.avatarPicture,
    required this.card,
    required this.services,
  });
}
