import 'package:beat_ecoprove/core/widgets/horizontal_selector/filter_card_type.dart';
import 'package:flutter/material.dart';

class HorizontalSelectorList extends StatefulWidget {
  final Map<String, String> list;
  final Function(List<String>) onSelectionChanged;

  const HorizontalSelectorList({
    super.key,
    required this.list,
    required this.onSelectionChanged,
  });

  @override
  State<HorizontalSelectorList> createState() => _HorizontalSelectorListState();
}

class _HorizontalSelectorListState extends State<HorizontalSelectorList> {
  final Map<String, String> items = {"all": "Tudo"};
  final List<String> selectedItems = [];
  late int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    items.addAll(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          GestureDetector(
            onTap: () {
              setState(() {
                var title = items.values.toList()[i];
                selectedIndex = i;

                if (!selectedItems.contains(title) && selectedIndex != 0) {
                  selectedItems.add(title);
                } else {
                  if (isHeadSelected(selectedIndex)) {
                    selectedItems.addAll(widget.list.values
                        .where((title) => !selectedItems.contains(title))
                        .toList());
                  } else {
                    if (selectedItems.length == items.length - 1 &&
                        selectedIndex != 0) {
                      selectedItems.clear();
                      selectedItems.add(title);
                    } else {
                      selectedItems.remove(title);
                    }
                  }
                }

                widget.onSelectionChanged(getIds());
              });
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              child: FilterCardType(
                title: items.values.toList()[i],
                selected: handleSelection(i),
              ),
            ),
          ),
        ],
      ],
    );
  }

  List<String> getIds() {
    return widget.list.keys
        .where((id) => selectedItems.contains(widget.list[id]))
        .toList();
  }

  bool isHeadSelected(int i) => selectedIndex == 0;

  handleSelection(int i) {
    if (selectedItems.contains(items.values.toList()[i])) {
      return true;
    }
    if (selectedItems.length == items.length - 1) {
      return true;
    }
    return false;
  }
}
