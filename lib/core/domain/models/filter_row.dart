class FilterRow {
  final List<FilterButtonItem> options;
  final String title;

  FilterRow({
    required this.options,
    required this.title,
  });
}

class FilterButtonItem<T> {
  final String text;
  final T content;
  final bool isCircular;
  final double dimension;

  FilterButtonItem({
    required this.text,
    required this.content,
    this.isCircular = false,
    this.dimension = 40,
  });
}
