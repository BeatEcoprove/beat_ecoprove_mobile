import 'package:beat_ecoprove/core/widgets/selector_button/selector_frame.dart';
import 'package:beat_ecoprove/core/widgets/selector_button/selector_item.dart';
import 'package:flutter/material.dart';

class SelectorButton extends StatefulWidget {
  final List<String> selectors;
  final void Function(int) onIndexChanged;

  const SelectorButton({
    required this.selectors,
    required this.onIndexChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectorButton> createState() => _SelectorButtonState();
}

class _SelectorButtonState extends State<SelectorButton> {
  static const double itemHeigth = SelectorItem.heigth;
  static const double itemGap = 20;
  static const Duration animationDuration = Duration(milliseconds: 150);

  int selectedIndex = 0;
  double currentGap = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            for (int i = 0; i < widget.selectors.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedIndex == i) {
                      return;
                    }

                    selectedIndex = i;
                    widget.onIndexChanged(selectedIndex);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.only(bottom: _getItemGap(i)),
                    child: SelectorItem(
                      title: widget.selectors[i],
                      selected: selectedIndex == i,
                    )),
              )
          ],
        ),
        AnimatedPositioned(
            top: _calculateMoveTo(),
            left: 0,
            right: 0,
            duration: animationDuration,
            curve: Curves.easeInOut,
            child: const SelectionFrame()),
      ],
    );
  }

  double _calculateMoveTo() => (itemGap + itemHeigth) * selectedIndex;

  double _getItemGap(int i) => i < widget.selectors.length - 1 ? itemGap : 0;
}
