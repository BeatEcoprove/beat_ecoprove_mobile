import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FilterCardType extends StatefulWidget {
  final String title;
  final bool selected;
  final VoidCallback? onPress;

  const FilterCardType({
    super.key,
    required this.title,
    this.selected = false,
    this.onPress,
  });

  static const Radius borderRadius = Radius.circular(10);

  @override
  State<FilterCardType> createState() => _FilterCardTypeState();
}

class _FilterCardTypeState extends State<FilterCardType>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _animation = ColorTween(
      begin: Colors.transparent,
      end: AppColor.darkGreen,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final isSelect = widget.selected;

    if (isSelect) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) widget.onPress!();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Container(
          width: 100,
          height: 38,
          decoration: BoxDecoration(
            color: AppColor.widgetBackground,
            borderRadius: const BorderRadius.all(FilterCardType.borderRadius),
            border: Border.all(color: _animation.value!, width: 2.0),
            boxShadow: const [AppColor.defaultShadow],
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: AppText.subHeader,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
