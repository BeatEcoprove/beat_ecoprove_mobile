import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class IconButtonRectangular extends StatefulWidget {
  static const Radius borderRadius = Radius.circular(10);

  final String? idText;
  final bool isSelected;
  final VoidCallback? onPress;
  final bool addBorderOnPress;
  final Color colorBackground;
  final Widget object;
  final double dimension;
  final bool isCircular;

  const IconButtonRectangular({
    Key? key,
    required this.object,
    this.idText,
    this.isSelected = false,
    this.colorBackground = AppColor.widgetBackground,
    this.onPress,
    this.addBorderOnPress = false,
    this.dimension = 40,
    this.isCircular = false,
  }) : super(key: key);

  @override
  State<IconButtonRectangular> createState() => _IconButtonRectangularState();
}

class _IconButtonRectangularState extends State<IconButtonRectangular>
    with SingleTickerProviderStateMixin {
  static const Radius borderRadius = Radius.circular(5);
  late AnimationController _controller;
  late Animation<Color?> _animation;
  late bool _isSelect = widget.isSelected;

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
    if (_isSelect) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return GestureDetector(
      onTap: () {
        if (widget.onPress != null) widget.onPress!();
        if (widget.addBorderOnPress) _isSelect = !_isSelect;
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Container(
          width: widget.dimension,
          height: widget.dimension,
          decoration: BoxDecoration(
            color: widget.colorBackground,
            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
            border: Border.all(color: _animation.value!, width: 2.0),
            borderRadius:
                widget.isCircular ? null : const BorderRadius.all(borderRadius),
            boxShadow: const [AppColor.defaultShadow],
          ),
          child: Center(child: widget.object),
        ),
      ),
    );
  }
}

enum IconButtonRetangularType implements Comparable<IconButtonRetangularType> {
  recycle(
      colorBackground: AppColor.darkGreen,
      object: SvgImage(
        path: 'assets/services/recycle.svg',
        width: 30,
        height: 30,
      )),
  iron(
      colorBackground: AppColor.orange,
      object: SvgImage(
        path: 'assets/services/iron.svg',
        width: 30,
        height: 30,
      )),
  dry(
      colorBackground: AppColor.yellow,
      object: SvgImage(
        path: 'assets/services/dry.svg',
        width: 30,
        height: 30,
      )),
  wash(
      colorBackground: AppColor.lightBlue,
      object: SvgImage(
        path: 'assets/services/wash.svg',
        width: 50,
        height: 50,
      )),
  repair(
      colorBackground: AppColor.darkBlue,
      object: SvgImage(
        path: 'assets/services/repair.svg',
        width: 30,
        height: 30,
      ));

  final Color colorBackground;
  final Widget object;

  const IconButtonRetangularType({
    required this.colorBackground,
    required this.object,
  });

  @override
  int compareTo(IconButtonRetangularType other) {
    throw UnimplementedError();
  }
}
