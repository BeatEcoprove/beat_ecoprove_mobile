import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class WrapFilterOptions extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) filterIsSelect;

  final String title;
  final List<FilterButtonItem> filterOptions;

  const WrapFilterOptions({
    Key? key,
    required this.title,
    required this.filterOptions,
    required this.onSelectionChanged,
    required this.filterIsSelect,
  }) : super(key: key);

  @override
  State<WrapFilterOptions> createState() => _WrapFilterOptionsState();
}

class _WrapFilterOptionsState extends State<WrapFilterOptions> {
  final List<String> selectedFilterButtons = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppText.smallHeader,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 6,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          runSpacing: 6,
          spacing: 6,
          children: [
            for (int i = 0; i < widget.filterOptions.length; i++) ...[
              renderFilterButton(i),
            ]
          ],
        ),
      ],
    );
  }

  renderFilterButton(int i) {
    var filterButton = widget.filterOptions[i];

    return IconButtonRectangular(
      addBorderOnPress: true,
      idText: filterButton.text,
      object: filterButton.content,
      isCircular: filterButton.isCircular,
      dimension: filterButton.dimension,
      isSelected: widget.filterIsSelect(widget.filterOptions[i].text),
      onPress: () => setState(() {
        selectedFilterButtons.add(widget.filterOptions[i].text);

        widget.onSelectionChanged(selectedFilterButtons);
        selectedFilterButtons.clear();
      }),
    );
  }
}
