import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:flutter/material.dart';

class Filter {
  final String text;
  final Widget? content;
  final double dimension;
  final Color? color;
  final String value;
  final String tag;

  Filter({
    required this.text,
    this.content,
    this.dimension = 40,
    this.color,
    required this.value,
    required this.tag,
  });

  FilterButtonItem toFilterButton() {
    return FilterButtonItem(
      text: text,
      content: content,
      dimension: dimension,
      backgroundColor: color,
      value: value,
      tag: tag,
    );
  }
}
