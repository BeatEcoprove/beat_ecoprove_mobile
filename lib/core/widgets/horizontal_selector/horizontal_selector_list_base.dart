import 'package:flutter/material.dart';

abstract class HorizontalSelectorListBase extends StatefulWidget {
  final Map<String, String> list;
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) isHorizontalFilterSelected;

  const HorizontalSelectorListBase({
    super.key,
    required this.list,
    required this.onSelectionChanged,
    required this.isHorizontalFilterSelected,
  });

  @override
  State<HorizontalSelectorListBase> createState();
}

abstract class HorizontalSelectorListBaseState<
    T extends HorizontalSelectorListBase> extends State<T> {
  final Map<String, String> items = {};
  late List<String> selectedItems = [];

  @override
  void initState();

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

  Widget renderHorizontalFilter(int i);

  bool handleSelection(String title);
}
