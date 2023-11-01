import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formatted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneFormattedTextField extends FormattedTextField {
  final Function(String, String) onChangeCountryCode;
  final Map<String, String> countryCodes;

  const PhoneFormattedTextField({
    super.hintText = 'Default Value',
    super.isPassword = false,
    super.errorMessage = '',
    super.keyboardType = TextInputType.text,
    super.inputFormatter,
    super.leftIcon,
    super.onChange,
    super.initialValue,
    required this.countryCodes,
    required this.onChangeCountryCode,
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneFormattedTextField> createState() =>
      _PhoneFormattedTextFieldState();
}

class _PhoneFormattedTextFieldState
    extends FormattedTextFieldState<PhoneFormattedTextField>
    with BaseFormattedTextField {
  late String selectedCountry = _comboOutput("pt", "+351");

  convertStringToMap() {
    return widget.countryCodes.entries.map((entry) {
      return _comboOutput(entry.key, entry.value);
    }).toList();
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(BaseFormattedTextField.borderRadius),
          border: Border.all(
            color: isFocus ? fieldType.focusColor : fieldType.color,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColor.widgetSecondary),
              style: const TextStyle(
                fontSize: AppText.title4,
                color: AppColor.widgetSecondary,
                fontWeight: FontWeight.bold,
              ),
              value: selectedCountry,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value!;
                  widget.onChangeCountryCode(
                      value.split(" ").last.trim(), _getPhoneValue());
                });
              },
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              items: convertStringToMap()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (value) => widget.onChangeCountryCode(
                    selectedCountry, _getPhoneValue()),
                keyboardType: widget.keyboardType,
                inputFormatters: [
                  PhoneNumberFormatter(),
                  ...widget.inputFormatter ?? widget.inputFormatter ?? []
                ],
                style: const TextStyle(
                  fontSize: AppText.title4,
                ),
                obscureText: widget.isPassword,
                cursorColor: fieldType.focusColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  labelStyle: TextStyle(
                    fontSize: AppText.title5,
                    color: colorizeOnFocus(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPhoneValue() {
    return controller.text.trim().replaceAll(" ", "");
  }

  String _toContryFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }

  String _comboOutput(String countryCode, String countryId) {
    return "${_toContryFlag(countryCode)} $countryId";
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '',
      );
    }

    final cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');
    final formattedText = _formatPhoneNumber(cleanText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatPhoneNumber(String input) {
    if (input.length <= 3) {
      return input;
    } else if (input.length <= 6) {
      return '${input.substring(0, 3)} ${input.substring(3)}';
    } else {
      return '${input.substring(0, 3)} ${input.substring(3, 6)} ${input.substring(6)}';
    }
  }
}
