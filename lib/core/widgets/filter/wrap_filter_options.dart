import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class WrapFilterOptions extends StatefulWidget {
  final String title;
  final List<IconButtonRectangular> filterOptions;

  const WrapFilterOptions({
    Key? key,
    required this.title,
    required this.filterOptions,
  }) : super(key: key);

  @override
  State<WrapFilterOptions> createState() => _WrapFilterOptionsState();
}

class _WrapFilterOptionsState extends State<WrapFilterOptions> {
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
              widget.filterOptions[i],
            ]
          ],
        ),
      ],
    );
  }
}
