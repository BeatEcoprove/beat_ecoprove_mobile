import 'dart:ui';

class FilterRow {
  final List<FilterButtonItem> options;
  final String? title;
  final bool isCircular;

  FilterRow({
    required this.options,
    this.title,
    this.isCircular = false,
  });
}

class FilterButtonItem<T> {
  final String text;
  final T? content;
  final double dimension;
  final Color? backgroundColor;
  final String value;

  FilterButtonItem({
    required this.text,
    this.content,
    this.dimension = 40,
    this.backgroundColor,
    required this.value,
  });
}
