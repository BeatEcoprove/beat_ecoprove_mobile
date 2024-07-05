import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/worker_header/worker_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:flutter/material.dart';

class WorkerCanEditPrivilegiesHeader extends WorkerHeader {
  final List<String> dropOptions;
  final String dropOptionsValue;
  final Function(String) dropOptionsSet;

  const WorkerCanEditPrivilegiesHeader({
    super.key,
    required super.title,
    required super.subTitle,
    required this.dropOptions,
    required this.dropOptionsValue,
    required this.dropOptionsSet,
    super.height = HeightCard.height88,
  });

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: ((2 / 3) * width) - 80 - 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppText.smallHeader,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subTitle,
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(
          height: height.value / 2,
          width: 135,
          child: FormattedDropDown(
            options: dropOptions,
            value: dropOptionsValue,
            onValueChanged: dropOptionsSet,
          ),
        ),
      ],
    );
  }
}
