import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_card.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget.dart';
import 'package:flutter/material.dart';

class FilterColor extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) filterIsSelect;
  final List<String> selectedFilters;

  final List<FilterRow> options;

  const FilterColor({
    super.key,
    required this.options,
    required this.onSelectionChanged,
    required this.filterIsSelect,
    required this.selectedFilters,
  });

  @override
  State<FilterColor> createState() => _FilterColorState();
}

class _FilterColorState extends State<FilterColor> {
  final OverlayWidget _overlay = OverlayWidget(
    top: 36,
    bottom: 36,
    button: const Icon(
      Icons.close_rounded,
      size: 36,
      color: AppColor.widgetSecondary,
    ),
    buttonRight: 36,
    buttonTop: 36,
  );

  void _toggleFilter(BuildContext context) {
    _overlay.create(
      context,
      FilterCard(
        paddingRight: 30,
        paddingLeft: 30,
        paddingTop: 106,
        paddingBottom: 106,
        needOnlyOne: true,
        options: widget.options,
        filterIsSelect: widget.filterIsSelect,
        onSelectionChanged: widget.onSelectionChanged,
        selectedFilters: widget.selectedFilters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double dimension = 50;

    return GestureDetector(
      onTap: () {
        _toggleFilter(context);
      },
      child: Container(
        width: dimension,
        height: dimension,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
          boxShadow: [AppColor.defaultShadow],
        ),
      ),
    );
  }
}
