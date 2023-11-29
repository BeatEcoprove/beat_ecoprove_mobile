import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_card.dart';
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

  void _toggleFilter(BuildContext context) {
    _overlay.create(
      context,
      FilterCard(
        paddingBottom: widget.contentPaddingBottom,
        paddingTop: widget.contentPaddingTop,
        paddingLeft: widget.contentPaddingLeft,
        paddingRight: widget.contentPaddingRight,
        needOnlyOne: widget.needOnlyOne,
        options: widget.options,
        filterIsSelect: widget.filterIsSelect,
        onSelectionChanged: widget.onSelectionChanged,
        selectedFilters: widget.selectedFilters,
        overlay: _overlay,
      ),
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
