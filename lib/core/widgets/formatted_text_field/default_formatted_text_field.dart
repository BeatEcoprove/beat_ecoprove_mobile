import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formatted_text_field.dart';
import 'package:flutter/material.dart';

class DefaultFormattedTextField extends FormattedTextField {
  const DefaultFormattedTextField({
    super.hintText = 'Default Value',
    super.isPassword = false,
    super.errorMessage = '',
    super.keyboardType = TextInputType.text,
    super.inputFormatter,
    super.leftIcon,
    super.onChange,
    super.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<DefaultFormattedTextField> createState() =>
      _DefaultFormattedFieldState();
}

class _DefaultFormattedFieldState
    extends FormattedTextFieldState<DefaultFormattedTextField>
    with BaseFormattedTextField {
  @override
  @override
  Widget body(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: widget.onChange,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatter ?? widget.inputFormatter,
      obscureText: widget.isPassword,
      cursorColor: fieldType.focusColor,
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
    );
  }
}
