import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'formatted_text_field_type.dart';

class FormattedTextField extends StatefulWidget {
  final FormattedTextFieldType fieldType;
  final bool isPassword;
  final String hintText;
  final String errorMessage;
  final TextInputType keyboardType;
  final Icon? leftIcon;
  final List<TextInputFormatter>? inputFormatter;

  const FormattedTextField({
    this.fieldType = FormattedTextFieldType.normal,
    this.hintText = 'Default Value',
    this.isPassword = false,
    this.errorMessage = '', // errorMessage is now optional
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.leftIcon,
    Key? key,
  }) : super(key: key);

  @override
  State<FormattedTextField> createState() => _FormattedTextFieldState();
}

class _FormattedTextFieldState extends State<FormattedTextField> {
  static const Radius borderRadius = Radius.circular(5);

  bool isFocus = false;

  OutlineInputBorder getInputBorder() {
    bool isDefault = isFocus;

    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(borderRadius),
      borderSide: BorderSide(
          color:
              isDefault ? widget.fieldType.focusColor : widget.fieldType.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(borderRadius),
              color: AppColor.widgetBackgroud,
              boxShadow: [AppColor.defaultShadow],
            ),
            child: Focus(
              onFocusChange: (hasFoucs) => {
                setState(
                  () {
                    isFocus = hasFoucs;
                  },
                )
              },
              child: TextField(
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatter ?? widget.inputFormatter,
                obscureText: widget.isPassword,
                cursorColor: widget.fieldType.focusColor,
                decoration: InputDecoration(
                  labelText: widget.hintText,
                  labelStyle: TextStyle(
                    fontSize: AppText.title5,
                    color: colorizeOnFocus(),
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: getInputBorder(),
                  enabledBorder: getInputBorder(),
                  suffixIcon: Icon(
                    widget.leftIcon?.icon,
                    color: colorizeOnFocus(),
                  ),
                ),
              ),
            )),
        if (_isErrorType)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.errorMessage,
                style: TextStyle(color: widget.fieldType.focusColor),
              ),
            ),
          )
      ],
    );
  }

  bool get _isErrorType {
    return widget.fieldType == FormattedTextFieldType.error &&
        widget.errorMessage.isNotEmpty;
  }

  Color colorizeOnFocus() =>
      isFocus ? widget.fieldType.focusColor : AppColor.widgetSecondary;
}
