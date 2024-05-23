import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_row_options.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final Widget bodyButton;
  final Widget? headerButton;
  final double bodyRight;
  final double bodyTop;
  final double overlayPaddingBottom;
  final double overlayPaddingLeft;
  final double overlayPaddingRight;
  final double overlayPaddingTop;
  final double contentPaddingBottom;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double contentPaddingTop;
  final bool needOnlyOne;
  final Function(Map<String, dynamic>) onSelectionChanged;
  final bool Function(String) filterIsSelect;
  final Map<String, dynamic> selectedFilters;

  final List<FilterRow> options;

  const FilterButton({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    required this.filterIsSelect,
    required this.selectedFilters,
    required this.bodyButton,
    this.headerButton,
    this.bodyRight = 0,
    this.bodyTop = 0,
    this.overlayPaddingBottom = 16,
    this.overlayPaddingLeft = 16,
    this.overlayPaddingRight = 16,
    this.overlayPaddingTop = 16,
    this.contentPaddingBottom = 16,
    this.contentPaddingLeft = 16,
    this.contentPaddingRight = 16,
    this.contentPaddingTop = 16,
    this.needOnlyOne = false,
  });

  @override
  State<FilterButton> createState() => _FilterButton();
}

class _FilterButton extends State<FilterButton> {
  late OverlayWidget _overlay;
  late Map<String, dynamic> selectedFilterButtons = {...widget.selectedFilters};
  late String selectedInRow = '';

  @override
  void initState() {
    super.initState();

    _overlay = OverlayWidget(
      top: widget.overlayPaddingTop,
      bottom: widget.overlayPaddingBottom,
      right: widget.overlayPaddingRight,
      left: widget.overlayPaddingLeft,
      button: widget.headerButton == null
          ? widget.bodyButton
          : widget.headerButton!,
      buttonRight: widget.bodyRight,
      buttonTop: widget.bodyTop,
    );
  }

  void getAllFilters(
      Map<String, dynamic> filters, Set<String> hasOnlyOnePerRow) {
    for (var filterSelected in filters.keys) {
      if (widget.filterIsSelect(filterSelected) && !widget.needOnlyOne) {
        selectedFilterButtons.remove(filterSelected);
      } else {
        if (widget.needOnlyOne) selectedFilterButtons.clear();

        if (hasOnlyOnePerRow.isNotEmpty) {
          for (var tag in hasOnlyOnePerRow) {
            for (var filter in filters.entries) {
              if (tag.contains(
                      (filter.value as Map<String, String>).values.first) &&
                  haveFiltersWithThisTag(tag)) {
                selectedFilterButtons.remove(selectedInRow);
                selectedInRow = '';
              }
            }
          }
        }

        selectedFilterButtons[filterSelected] = filters[filterSelected];

        if (widget.needOnlyOne) _overlay.remove();
      }
    }

    widget.onSelectionChanged(selectedFilterButtons);
  }

  void selectedInOnlyOneRow(String filter) {
    selectedInRow = filter;
  }

  bool haveFiltersWithThisTag(String tag) {
    for (var entry in widget.selectedFilters.entries) {
      if ((entry.value as Map<String, String>).values.first == tag &&
          widget.filterIsSelect(entry.key)) {
        selectedInOnlyOneRow(entry.key);
        return true;
      }
    }
    return false;
  }

  FilterRowOptions renderRowOptions(FilterRow option) {
    return FilterRowOptions(
      title: option.title,
      isCircular: option.isCircular,
      filterOptions: option.options,
      hasOnlyOne: option.hasOnlyOne,
      filterIsSelect: widget.filterIsSelect,
      onSelectionChanged: getAllFilters,
    );
  }

  Widget createFilterCard() {
    const Radius borderRadius = Radius.circular(5);

    return Container(
      padding: EdgeInsets.only(
        right: widget.contentPaddingRight,
        left: widget.contentPaddingLeft,
        top: widget.contentPaddingTop,
        bottom: widget.contentPaddingBottom,
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

  void _toggleFilter(BuildContext context) {
    _overlay.create(
      context,
      createFilterCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleFilter(context);
      },
      child: widget.bodyButton,
    );
  }
}
