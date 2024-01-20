import 'package:beat_ecoprove/clothing/contracts/cloth_result.dart';
import 'package:flutter/material.dart';

class CardItem<T> {
  final String id;
  final ClothStates? clothState;
  final String title;
  final String? brand;
  final T child;
  final ImageProvider? hasProfile;
  final String? size;
  final Color? color;
  final int? ecoScore;

  CardItem({
    required this.id,
    this.clothState,
    required this.title,
    required this.child,
    this.hasProfile,
    this.brand = '',
    this.size = 'XS',
    this.color = Colors.black,
    this.ecoScore = 0,
  });

  bool get hasChildren => child is List<CardItem>;
}
