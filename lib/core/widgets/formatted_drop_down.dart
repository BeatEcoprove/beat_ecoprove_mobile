import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FormattedDropDown extends StatefulWidget {
  final List<String> options;
  final String? value;
  final void Function(String value)? onValueChanged;

  const FormattedDropDown(
      {required this.options, this.onValueChanged, this.value, Key? key})
      : super(key: key);

  @override
  State<FormattedDropDown> createState() => _FormattedDropDownState();
}

class _FormattedDropDownState extends State<FormattedDropDown> {
  late String _value;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    _value = widget.value ?? widget.options.first;

    return Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [AppColor.defaultShadow],
            color: Colors.white,
            border: Border.all(
              color: isFocused ? AppColor.primaryColor : Colors.white,
            ),
            borderRadius: AppColor.borderRadius),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 20),
          child: DropdownButton<String>(
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColor.widgetSecondary),
            focusColor: Colors.transparent,
            style: const TextStyle(
              fontSize: AppText.title5,
              color: AppColor.widgetSecondary,
              fontWeight: FontWeight.bold,
            ),
            value: _value,
            isExpanded: true,
            items: widget.options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _value = value;

                  if (widget.onValueChanged != null) {
                    widget.onValueChanged!(_value);
                  }
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
