import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/compact_list_item_header.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class ImageTitleSubtitleHeader extends CompactListItemHeader {
  final Widget widget;
  final String subTitle;
  final bool isCircular;
  final bool withoutBoxShadow;

  const ImageTitleSubtitleHeader({
    super.key,
    required this.widget,
    required super.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * (2 / 3) - 60;

    return Row(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: maxWidth,
              child: Text(
                title,
                style: AppText.headerBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: maxWidth,
              child: Text(
                subTitle,
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }
}
