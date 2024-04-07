import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(20);

  final VoidCallback onAction;
  final String text;
  final String textWhenSelected;
  final Widget object;
  final double height;
  final double width;
  final double widthRightPart;
  final Color firstPartButtonColor;
  final Color secondPartButtonColor;
  final Color firstPartButtonColorWhenSelected;
  final Color secondPartButtonColorWhenSelected;
  final bool isSelect;
  final bool disabled;

  const RoundedButton({
    super.key,
    required this.onAction,
    required this.text,
    required this.textWhenSelected,
    this.object = const Icon(
      Icons.directions_walk_rounded,
      color: AppColor.widgetBackground,
    ),
    this.height = 42,
    this.width = 100,
    this.widthRightPart = 50,
    this.firstPartButtonColor = AppColor.buttonBackground,
    this.secondPartButtonColor = AppColor.bucketButton,
    this.firstPartButtonColorWhenSelected = AppColor.widgetSecondary,
    this.secondPartButtonColorWhenSelected = AppColor.bucketButton,
    this.isSelect = false,
    this.disabled = false,
  });

  Container _firstPartButton(Color color, String textSelection) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
            topLeft: borderRadius, bottomLeft: borderRadius),
        boxShadow: const [AppColor.defaultShadow],
      ),
      child: Center(
        child: Text(
          textSelection,
          textAlign: TextAlign.start,
          style: AppText.textButton,
        ),
      ),
    );
  }

  Container _secondPartButton(Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: widthRightPart,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
            topRight: borderRadius, bottomRight: borderRadius),
        boxShadow: const [AppColor.defaultShadow],
      ),
      child: object,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? () => {} : onAction,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _firstPartButton(
            disabled
                ? AppColor.darkGrey
                : isSelect
                    ? firstPartButtonColorWhenSelected
                    : firstPartButtonColor,
            isSelect ? textWhenSelected : text,
          ),
          _secondPartButton(
            isSelect
                ? secondPartButtonColorWhenSelected
                : secondPartButtonColor,
          )
        ],
      ),
    );
  }
}
