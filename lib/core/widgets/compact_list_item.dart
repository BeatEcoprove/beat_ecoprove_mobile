import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_retangular.dart';
import 'package:flutter/material.dart';

class CompactListItem extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final VoidCallback? options;

  final Widget widget;
  final String title;
  final String subTitle;

  const CompactListItem(
      {super.key,
      required this.widget,
      required this.title,
      required this.subTitle,
      this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      padding: const EdgeInsets.all(8),
      height: 75,
      decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: BorderRadius.all(borderRadius),
          boxShadow: [AppColor.defaultShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonRetangular(dimension: 60, object: widget),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: AppText.headerBlack,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subTitle,
                    style: AppText.subHeader,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: options,
            icon: const Icon(Icons.more_vert_rounded),
            color: AppColor.widgetSecondary,
          )
        ],
      ),
    );
  }
}
