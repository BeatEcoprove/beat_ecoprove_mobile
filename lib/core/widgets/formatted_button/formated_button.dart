import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formatted_button_type.dart';
import 'package:flutter/material.dart';

class FormattedButton extends StatefulWidget {
  static const double defaultHeight = 46;

  final String content;
  final double height;
  final void Function()? onPress;
  final bool disabled;
  final bool loading;
  final Color? buttonColor;
  final Color textColor;

  const FormattedButton({
    required this.content,
    this.height = defaultHeight,
    this.onPress,
    this.disabled = false,
    this.loading = false,
    Key? key,
    this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  State<FormattedButton> createState() => _FormattedButtonState();
}

class _FormattedButtonState extends State<FormattedButton> {
  static const double defaultWidth = 247;
  static const Radius defaultRadius = Radius.circular(10);

  late FormattedButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    buttonType = widget.disabled
        ? FormattedButtonType.disabled
        : FormattedButtonType.normal;

    return InkWell(
      onTap: widget.disabled ? null : widget.onPress,
      child: Container(
        height: widget.height,
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: defaultWidth),
        decoration: BoxDecoration(
          boxShadow: const [AppColor.defaultShadow],
          borderRadius: const BorderRadius.all(defaultRadius),
          color: widget.buttonColor ?? buttonType.color,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.loading)
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12, right: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColor.primaryColor,
                      color: Colors.white,
                    ),
                  ),
                ),
              Text(
                widget.loading ? "Carregando" : widget.content,
                style: TextStyle(
                  fontSize: AppText.title3,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
