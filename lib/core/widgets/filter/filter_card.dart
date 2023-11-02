import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/filter/wrap_filter_options.dart';
import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  final List<WrapFilterOptions> options;

  const FilterCard({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  @override
  Widget build(BuildContext context) {
    const Radius borderRadius = Radius.circular(5);

    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 50,
        bottom: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < widget.options.length; i++) ...[
              widget.options[i],
              const SizedBox(
                height: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
