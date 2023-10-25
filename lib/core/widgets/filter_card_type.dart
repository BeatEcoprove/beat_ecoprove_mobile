import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FilterCardType extends StatefulWidget {
  final String title;
  final bool isSelected;

  const FilterCardType({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  State<FilterCardType> createState() => _FilterCardTypeState();
}

class _FilterCardTypeState extends State<FilterCardType> {
  static const Radius borderRadius = Radius.circular(10);
  late bool isSelected = widget.isSelected;

  void handleClick() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleClick,
      child: Container(
        width: 100,
        height: 38,
        decoration: BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: const BorderRadius.all(borderRadius),
          border: isSelected
              ? Border.all(
                  color: AppColor.darkGreen,
                  width: 2.0,
                )
              : null,
          boxShadow: const [AppColor.defaultShadow],
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: AppText.subHeader,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
