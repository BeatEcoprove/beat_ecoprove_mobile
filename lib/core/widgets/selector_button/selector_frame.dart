import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/selector_button/selector_item.dart';
import 'package:flutter/material.dart';

class SelectionFrame extends StatelessWidget {
  static const double strokeWeight = 2;

  const SelectionFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: SelectorItem.selectorContrains,
      child: Container(
        height: SelectorItem.heigth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: AppColor.borderRadius,
          border: Border.all(
            color: AppColor.darkGreen,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
