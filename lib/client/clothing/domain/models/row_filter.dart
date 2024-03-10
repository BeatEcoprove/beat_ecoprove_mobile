import 'package:beat_ecoprove/client/clothing/domain/models/filter.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';

class RowFilter {
  final List<Filter> options;
  final String? title;
  final bool isCircular;

  RowFilter({
    required this.options,
    this.title,
    this.isCircular = false,
  });

  FilterRow toFilterRow() {
    return FilterRow(
        title: title,
        isCircular: isCircular,
        options: options.map((option) {
          return option.toFilterButton();
        }).toList());
  }
}
