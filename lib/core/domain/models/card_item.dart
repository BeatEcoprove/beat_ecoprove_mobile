import 'package:flutter/material.dart';

class CardItem<T> {
  final String id;
  final String title;
  final String? subTitle;
  final String? brand;
  final T child;
  final ImageProvider? hasProfile;
  final String? size;
  final Color? color;
  final int? ecoScore;

  CardItem({
    required this.id,
    required this.title,
    this.subTitle,
    required this.child,
    this.hasProfile,
    this.brand = '',
    this.size = 'M',
    this.color = Colors.black,
    this.ecoScore = 0,
  });

  bool get hasChildren => child is List<CardItem>;
}
