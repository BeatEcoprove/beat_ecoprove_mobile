import 'package:flutter/material.dart';

class CardItem<T> {
  final String title;
  final String? subTitle;
  final T child;
  final ImageProvider? hasProfile;

  CardItem({
    required this.title,
    this.subTitle,
    required this.child,
    this.hasProfile,
  });

  bool get hasChildren => child is List<CardItem>;
}
