import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_card.dart';
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
  OverlayEntry? _overlayEntry;
  static const Radius borderRadius = Radius.circular(5);

  void _toggleFilter(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    } else {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              bottom: 86,
              top: position.dy,
              child: FilterCard(
                options: widget.options,
                onSelectionChanged: widget.onSelectionChanged,
                filterIsSelect: widget.filterIsSelect,
                selectedFilters: widget.selectedFilters,
              ),
            ),
            Positioned(
              right: 16,
              top: position.dy,
              child: GestureDetector(
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
              ),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    }
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
