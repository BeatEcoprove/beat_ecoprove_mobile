import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/filter_row.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class FilterRowOptions extends StatefulWidget {
  final VoidCallback? onBeforeButtonTap;

  final Function(Map<String, dynamic>, Set<String>) onSelectionChanged;
  final bool Function(String) filterIsSelect;

  final String? title;
  final List<FilterButtonItem> filterOptions;
  final bool isCircular;
  final bool hasOnlyOne;
  final VoidCallback? button;

  const FilterRowOptions({
    Key? key,
    required this.title,
    required this.isCircular,
    required this.filterOptions,
    required this.onSelectionChanged,
    required this.filterIsSelect,
    this.hasOnlyOne = false,
    this.button,
    this.onBeforeButtonTap,
  }) : super(key: key);

  @override
  State<FilterRowOptions> createState() => _FilterRowOptionsState();
}

class _FilterRowOptionsState extends State<FilterRowOptions> {
  final Map<String, Map<String, String>> selectedFilterButtons = {};
  final Set<String> hasOnlyOnePerRow = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.title != null) ...[
              Text(
                widget.title!,
                style: AppText.smallHeader,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (widget.button != null) ...[
              GestureDetector(
                onTap: () => {
                  widget.button?.call(),
                  if (widget.onBeforeButtonTap != null)
                    {
                      widget.onBeforeButtonTap!(),
                    },
                },
                child: Text(
                  LocaleContext.get().core_see_more,
                  textAlign: TextAlign.center,
                  style: AppText.smallHeaderGreen,
                ),
              ),
            ]
          ],
        ),
        const SizedBox(
          height: 4,
        ),
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
        const SizedBox(
          height: 12,
        )
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
      isSelected: widget.filterIsSelect(option.text),
      onPress: () => setState(() {
        selectedFilterButtons.addAll({
          option.text: {option.value: option.tag}
        });

        if (widget.hasOnlyOne) hasOnlyOnePerRow.add(option.tag);

        widget.onSelectionChanged(selectedFilterButtons, hasOnlyOnePerRow);
        selectedFilterButtons.clear();
        hasOnlyOnePerRow.clear();
      }),
    );
  }
}
