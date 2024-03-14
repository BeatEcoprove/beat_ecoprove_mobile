import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/worker_header/worker_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:flutter/material.dart';

class WorkerCanEditPrivilegiesHeader extends WorkerHeader {
  final String workerType;

  const WorkerCanEditPrivilegiesHeader({
    super.key,
    required super.title,
    required super.subTitle,
    required this.workerType,
    super.height = HeightCard.height88,
  });

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    const Radius borderRadius = Radius.circular(10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: ((2 / 3) * width) - 80,
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
        Container(
          height: height.value / 2,
          width: 125,
          decoration: const BoxDecoration(
            color: AppColor.widgetBackground,
            borderRadius: BorderRadius.all(borderRadius),
            boxShadow: [AppColor.defaultShadow],
          ),
          child: Text(
            workerType,
            style: AppText.subHeader,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
