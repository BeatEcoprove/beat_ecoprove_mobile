import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class CompactListItem extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final VoidCallback? options;

  final Widget widget;
  final String title;
  final String subTitle;
  final bool isCircular;
  final bool withoutBoxShadow;
  final Widget widgetOptions;
  final String? state;

  CompactListItem({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    this.options,
  })  : state = null,
        widgetOptions = IconButton(
          onPressed: options,
          icon: const Icon(Icons.more_vert_rounded),
          color: AppColor.widgetSecondary,
        );

  const CompactListItem.withoutOptions({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
  })  : state = null,
        options = null,
        widgetOptions = const SizedBox(
          width: 24,
        );

  CompactListItem.group({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.state,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    this.options,
  }) : widgetOptions = Stack(
          children: [
            Container(
              width: 60,
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: options,
                icon: const Icon(Icons.more_vert_rounded),
                color: AppColor.widgetSecondary,
              ),
            ),
            Positioned(
              bottom: 0,
              width: 65,
              child: Text(
                state!,
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 75,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonRectangular(
            isCircular: isCircular,
            dimension: 60,
            object: widget,
            withoutBoxShadow: withoutBoxShadow,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
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
          widgetOptions,
        ],
      ),
    );
  }
}
