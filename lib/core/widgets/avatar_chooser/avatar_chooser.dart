import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class AvatarChooser extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final VoidCallback? onPress;
  final BoxShape borderShape;
  final CustomPainter? foregroundPainter;
  final Widget image;

  const AvatarChooser({
    required this.height,
    required this.width,
    required this.color,
    required this.borderShape,
    this.foregroundPainter,
    required this.image,
    Key? key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(shape: borderShape),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            size: Size(width, height),
            foregroundPainter: foregroundPainter,
            child: image,
          ),
          Positioned(
              bottom: 5,
              right: 5,
              child: CircularButton(
                onPress: onPress,
                height: 46,
                icon: const Icon(
                  Icons.mode_edit_outline_outlined,
                  color: AppColor.widgetSecondary,
                  size: 26,
                ),
              )),
        ],
      ),
    );
  }
}
