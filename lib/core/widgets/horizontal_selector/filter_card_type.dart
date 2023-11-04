import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class FilterCardType extends StatelessWidget {
  final String title;
  final bool selected;

  const FilterCardType({
    super.key,
    required this.title,
    this.selected = false,
  });

  static const Radius borderRadius = Radius.circular(10);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 38,
      decoration: BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: const BorderRadius.all(borderRadius),
        border: selected
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
          title,
          style: AppText.subHeader,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
