import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class FilterRowOptions extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  final bool Function(String) filterIsSelect;

  final String? title;
  final List<FilterButtonItem> filterOptions;
  final bool isCircular;

  const FilterRowOptions({
    Key? key,
    required this.title,
    required this.isCircular,
    required this.filterOptions,
    required this.onSelectionChanged,
    required this.filterIsSelect,
  }) : super(key: key);

  @override
  State<FilterRowOptions> createState() => _FilterRowOptionsState();
}

class _FilterRowOptionsState extends State<FilterRowOptions> {
  final List<String> selectedFilterButtons = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: AppText.smallHeader,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 6,
          ),
        ],
        Wrap(
          alignment: WrapAlignment.start,
          runSpacing: 6,
          spacing: 6,
          children: [
            for (var option in widget.filterOptions) ...[
              renderFilterButton(option),
            ]
          ],
        ),
      ],
    );
  }

  IconButtonRectangular renderFilterButton(FilterButtonItem option) {
    return IconButtonRectangular(
      hasAnimation: true,
      idText: option.text,
      colorBackground: option.backgroundColor ?? AppColor.widgetBackground,
      object: option.content,
      isCircular: widget.isCircular,
      dimension: option.dimension,
      isSelected: handleSelection(option.text),
      onPress: () => setState(() {
        selectedFilterButtons.add(option.text);

        widget.onSelectionChanged(selectedFilterButtons);
        selectedFilterButtons.clear();
      }),
    );
  }

  bool handleSelection(title) {
    if (widget.filterIsSelect(title)) {
      return true;
    }
    return false;
  }
}
