import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_row_options.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget.dart';
import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  final Function(Map<String, dynamic>) onSelectionChanged;
  final bool Function(String) filterIsSelect;
  final Map<String, dynamic> selectedFilters;
  final double paddingRight;
  final double paddingLeft;
  final double paddingTop;
  final double paddingBottom;
  final bool needOnlyOne;
  final OverlayWidget overlay;

  final List<FilterRow> options;

  const FilterCard({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    required this.filterIsSelect,
    required this.selectedFilters,
    this.paddingRight = 18,
    this.paddingLeft = 18,
    this.paddingTop = 50,
    this.paddingBottom = 16,
    required this.needOnlyOne,
    required this.overlay,
  });

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  late Map<String, dynamic> selectedFilterButtons = {...widget.selectedFilters};

  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(5);

    return Container(
      padding: EdgeInsets.only(
        right: widget.paddingRight,
        left: widget.paddingLeft,
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
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
            for (var option in widget.options) ...[
              renderRowOptions(option),
            ],
          ],
        ),
      ),
    );
  }

  void getAllFilters(Map<String, dynamic> filters) {
    for (var filter in filters.keys) {
      if (widget.filterIsSelect(filter) && !widget.needOnlyOne) {
        selectedFilterButtons.remove(filter);
      } else {
        if (widget.needOnlyOne) selectedFilterButtons.clear();

        selectedFilterButtons[filter] = filters[filter];

        if (widget.needOnlyOne) widget.overlay.remove();
      }
    }

    widget.onSelectionChanged(selectedFilterButtons);
  }

  FilterRowOptions renderRowOptions(FilterRow option) {
    return FilterRowOptions(
      title: option.title,
      isCircular: option.isCircular,
      filterOptions: option.options,
      filterIsSelect: widget.filterIsSelect,
      onSelectionChanged: getAllFilters,
    );
  }
}
