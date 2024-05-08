import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/compact_list_item_header.dart';
import 'package:flutter/material.dart';

class TextHeader extends CompactListItemHeader {
  final String subTitle;
  final double widthFooter;

  const TextHeader({
    super.key,
    required super.title,
    required this.subTitle,
    this.widthFooter = 25,
  });

  @override
  Widget build(BuildContext context) {
    double width =
        ((MediaQuery.of(context).size.width) * (2 / 3)) - widthFooter;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width,
              child: Text(
                title,
                style: AppText.headerBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: width,
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
