import 'package:beat_ecoprove/core/widgets/horizontal_selector/filter_card_type.dart';
import 'package:flutter/material.dart';

class HorizontalSelectorList extends StatefulWidget {
  final Map<String, String> list;
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) isHorizontalFilterSelected;

  const HorizontalSelectorList({
    super.key,
    required this.list,
    required this.onSelectionChanged,
    required this.isHorizontalFilterSelected,
  });

  @override
  State<HorizontalSelectorList> createState() => _HorizontalSelectorListState();
}

class _HorizontalSelectorListState extends State<HorizontalSelectorList> {
  final Map<String, String> items = {"all": "Tudo"};
  late List<String> selectedItems = [];
  late int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    items.addAll(widget.list);
    selectedItems.addAll(widget.list.keys);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          Container(
            margin: const EdgeInsets.all(4),
            child: renderHorizontalFilter(i),
          ),
        ],
      ],
    );
  }

  renderHorizontalFilter(int i) {
    return FilterCardType(
      onPress: () => setState(() {
        var title = items.keys.toList()[i];
        selectedIndex = i;

        if (!selectedItems.contains(title) && !isHeadSelected(selectedIndex)) {
          selectedItems.add(title);
        } else if (isHeadSelected(selectedIndex)) {
          selectedItems.addAll(widget.list.keys
              .where((title) => !selectedItems.contains(title))
              .toList());
        } else if (selectedItems.length == items.length - 1 &&
            selectedIndex != 0) {
          selectedItems.clear();
          selectedItems.add(title);
        } else if (selectedItems.length > 1) {
          selectedItems.remove(title);
        }

        widget.onSelectionChanged(selectedItems);
      }),
      title: items.values.toList()[i],
      selected: handleSelection(items.keys.toList()[i]),
    );
  }

  bool isHeadSelected(int i) => selectedIndex == 0;

  handleSelection(title) {
    if (isAllSelected(title)) {
      return true;
    }
    if (selectedItems.contains(title) &&
        selectedItems.length < items.length - 1) {
      return true;
    }
    return false;
  }

  bool isAllSelected(title) {
    return selectedItems.length == items.length - 1 &&
        title == items.keys.toList()[0];
  }
}
