import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/wrap_filter_options.dart';
import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) filterIsSelect;
  final List<String> selectedFilters;

  final List<FilterRow> options;

  const FilterCard({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
    required this.filterIsSelect,
    required this.selectedFilters,
  }) : super(key: key);

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  late List<String> selectedFilterButtons = widget.selectedFilters;
  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(5);

    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 50,
        bottom: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < widget.options.length; i++) ...[
              renderFilterRow(i),
              const SizedBox(
                height: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  getAllFilters(List<String> filters) {
    for (int i = 0; i < filters.length; i++) {
      if (widget.filterIsSelect(filters[i])) {
        selectedFilterButtons.remove(filters[i]);
      } else {
        selectedFilterButtons.add(filters[i]);
      }
    }

    widget.onSelectionChanged(selectedFilterButtons);
  }

  renderFilterRow(int i) {
    var filterRow = widget.options[i];

    return WrapFilterOptions(
      title: filterRow.title,
      filterOptions: filterRow.options,
      filterIsSelect: widget.filterIsSelect,
      onSelectionChanged: getAllFilters,
    );
  }
}
