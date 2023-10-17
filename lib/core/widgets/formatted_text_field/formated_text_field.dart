import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'formatted_text_field_type.dart';

class FormattedTextField extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final String errorMessage;
  final TextInputType keyboardType;
  final Icon? leftIcon;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChange;
  final String? initialValue;

  const FormattedTextField({
    this.hintText = 'Default Value',
    this.isPassword = false,
    this.errorMessage = '', // errorMessage is now optional
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.leftIcon,
    this.onChange,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<FormattedTextField> createState() => _FormattedTextFieldState();
}

class _FormattedTextFieldState extends State<FormattedTextField> {
  static const Radius borderRadius = Radius.circular(5);

  late FormattedTextFieldType _fieldType;
  late TextEditingController _controller;
  bool isFocus = false;

  OutlineInputBorder getInputBorder() {
    bool isDefault = isFocus;

    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(borderRadius),
      borderSide: BorderSide(
          color: isDefault ? _fieldType.focusColor : _fieldType.color),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    _fieldType = widget.errorMessage.isNotEmpty
        ? FormattedTextFieldType.error
        : FormattedTextFieldType.normal;

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
                controller: _controller,
                onChanged: widget.onChange,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatter ?? widget.inputFormatter,
                obscureText: widget.isPassword,
                cursorColor: _fieldType.focusColor,
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
                style: TextStyle(color: _fieldType.focusColor),
              ),
            ),
          )
      ],
    );
  }

  bool get _isErrorType {
    return _fieldType == FormattedTextFieldType.error &&
        widget.errorMessage.isNotEmpty;
  }

  Color colorizeOnFocus() =>
      isFocus ? _fieldType.focusColor : AppColor.widgetSecondary;
}
