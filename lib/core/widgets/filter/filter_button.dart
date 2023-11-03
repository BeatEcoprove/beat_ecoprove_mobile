import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/filter/filter_card.dart';
import 'package:beat_ecoprove/core/widgets/filter/wrap_filter_options.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final VoidCallback? onPress;
  final SvgImage icon;
  final List<WrapFilterOptions> options;

  const FilterButton({
    super.key,
    this.onPress,
    this.icon = const SvgImage(
      path: "assets/filter/settings.svg",
      height: 24,
      width: 24,
      color: AppColor.widgetSecondary,
    ),
    required this.options,
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
