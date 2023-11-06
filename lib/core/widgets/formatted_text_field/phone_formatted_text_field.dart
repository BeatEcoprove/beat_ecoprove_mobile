import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/formatters/phone_formatter.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formatted_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneFormattedTextField extends FormattedTextField {
  final String? initialCountryCode;
  final Function(String, String) onChangeCountryCode;
  final Map<String, String> countryCodes;

  const PhoneFormattedTextField({
    this.initialCountryCode,
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
  late String selectedCountry;

  convertStringToMap() {
    return widget.countryCodes.entries.map((entry) {
      return _comboOutput(entry.key, entry.value);
    }).toList();
  }

  setDefaultCountryCode() {
    var countryCode = widget.initialCountryCode ?? "+351";

    widget.countryCodes.forEach((key, value) {
      if (value == countryCode) {
        countryCode = _comboOutput(key, value);
      }
    });

    return countryCode;
  }

  @override
  void initState() {
    super.initState();
    selectedCountry = setDefaultCountryCode();
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
                      _getCountryValue(), _getPhoneValue());
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
                    _getCountryValue(), _getPhoneValue()),
                keyboardType: widget.keyboardType,
                inputFormatters: [
                  PhoneNumberFormatter(),
                  LengthLimitingTextInputFormatter(11),
                  ...?widget.inputFormatter
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

  String _getCountryValue() {
    return selectedCountry.split(" ").last.trim();
  }

  String _toContryFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }

  String _comboOutput(String countryCode, String countryId) {
    return "${_toContryFlag(countryCode)} $countryId";
  }
}
