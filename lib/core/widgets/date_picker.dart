import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime? value;

  const DatePicker({this.value, Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  static const String _defualtDateFormat = "dd/MM/yyyy";
  static const int _maxYearsSupported = 100;

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
            data: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor, // header background color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.darkGreen, // button text color
                ),
              ),
            ),
            child: child!),
        initialDate: _selectedDate,
        firstDate: DateTime.now()
            .subtract(const Duration(days: 365 * _maxYearsSupported)),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [AppColor.defaultShadow],
          color: AppColor.widgetBackgroud,
          borderRadius: AppColor.borderRadius),
      child: InkWell(
        onTap: () async {
          await _selectDate(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat(_defualtDateFormat).format(_selectedDate),
                style: const TextStyle(
                  fontSize: AppText.title5,
                  color: AppColor.widgetSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.date_range_rounded,
                color: AppColor.widgetSecondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
