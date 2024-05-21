import 'package:beat_ecoprove/core/widgets/horizontal_selector/filter_card_type.dart';
import 'package:beat_ecoprove/core/widgets/horizontal_selector/horizontal_selector_list_base.dart';
import 'package:flutter/material.dart';

class HorizontalSelectorListStore extends HorizontalSelectorListBase {
  const HorizontalSelectorListStore({
    super.key,
    required super.list,
    required super.onSelectionChanged,
    required super.isHorizontalFilterSelected,
  });

  @override
  State<HorizontalSelectorListStore> createState() =>
      _HorizontalSelectorListStoreState();
}

class _HorizontalSelectorListStoreState
    extends HorizontalSelectorListBaseState<HorizontalSelectorListStore> {
  @override
  void initState() {
    super.initState();
    items.addAll(widget.list);
    selectedItems.add(widget.list.keys.first);
  }

  @override
  Widget renderHorizontalFilter(int i) {
    return FilterCardType(
      onPress: () => setState(() {
        var title = items.keys.toList()[i];

        if (!selectedItems.contains(title) && selectedItems.isEmpty) {
          selectedItems.add(title);
        } else if (selectedItems.isNotEmpty && !selectedItems.contains(title)) {
          selectedItems.clear();
          selectedItems.add(title);
        }

        print(selectedItems);

        widget.onSelectionChanged(selectedItems);
      }),
      title: items.values.toList()[i],
      selected: handleSelection(items.keys.toList()[i]),
    );
  }

  @override
  bool handleSelection(title) {
    if (selectedItems.contains(title)) {
      return true;
    }
    return false;
  }
}
