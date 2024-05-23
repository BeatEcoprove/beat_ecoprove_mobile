import 'dart:ui';

class FilterRow {
  final List<FilterButtonItem> options;
  final String? title;
  final bool isCircular;
  final bool hasOnlyOne;

  FilterRow({
    required this.options,
    this.title,
    this.isCircular = false,
    this.hasOnlyOne = false,
  });
}

class FilterButtonItem<T> {
  final String text;
  final T? content;
  final double dimension;
  final Color? backgroundColor;
  final String value;
  final String tag;

  FilterButtonItem({
    required this.text,
    this.content,
    this.dimension = 40,
    this.backgroundColor,
    required this.value,
    required this.tag,
  });
}
