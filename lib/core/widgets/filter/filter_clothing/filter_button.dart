import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_card.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) filterIsSelect;
  final List<String> selectedFilters;

  final SvgImage icon;
  final List<FilterRow> options;

  const FilterButton({
    super.key,
    this.icon = const SvgImage(
      path: "assets/filter/settings.svg",
      height: 24,
      width: 24,
      color: AppColor.widgetSecondary,
    ),
    required this.options,
    required this.onSelectionChanged,
    required this.filterIsSelect,
    required this.selectedFilters,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final OverlayWidget _overlay = OverlayWidget(
    top: 110,
    bottom: 86,
    button: Container(
      width: 52,
      height: 50,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: const SvgImage(
        path: "assets/filter/settings.svg",
        height: 24,
        width: 24,
        color: AppColor.widgetSecondary,
      ),
    ),
    buttonTop: 0,
  );

  static const Radius borderRadius = Radius.circular(5);

  void _toggleFilter(BuildContext context) {
    _overlay.create(
      context,
      FilterCard(
        options: widget.options,
        needOnlyOne: false,
        onSelectionChanged: widget.onSelectionChanged,
        filterIsSelect: widget.filterIsSelect,
        selectedFilters: widget.selectedFilters,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleFilter(context);
      },
      child: Container(
        width: 52,
        height: 50,
        decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: BorderRadius.all(borderRadius),
          boxShadow: [AppColor.defaultShadow],
        ),
        child: widget.icon,
      ),
    );
  }
}
