import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

class BucketItem extends CardItemTemplate {
  final List<CardItem> items;

  const BucketItem({
    super.key,
    required this.items,
    required super.title,
    super.otherProfileImage,
    super.isSelect,
    super.isSelectedToDelete,
    required super.cardSelectedToDelete,
  });

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = MediaQuery.of(context).size.width;
        double margin =
            maxWidth < AppColor.maxWidthToImageWithMediaQueryCards ? 4 : 6;
        double height =
            maxWidth < AppColor.maxWidthToImageWithMediaQueryCards ? 15 : 50;
        double width =
            maxWidth < AppColor.maxWidthToImageWithMediaQueryCards ? 15 : 40;
        return Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 1,
            spacing: 1,
            children: [
              for (int i = 0; i < 4; i++) ...[
                Container(
                  margin: EdgeInsets.all(margin),
                  child: Container(
                    height: height,
                    width: width,
                    color: AppColor.widgetBackground,
                    child: i < items.length
                        ? PresentImage(
                            path: NetworkImage(items[i].child),
                          )
                        : Container(
                            height: height,
                            width: width,
                            color: AppColor.widgetBackgroundWithNothing,
                          ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class ExtendedBucketItem {
  final List<CardItem> items;

  const ExtendedBucketItem({
    required this.items,
  });

  Widget build(BuildContext context) {
    double minWidth = 273;
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = MediaQuery.of(context).size.width;
        double margin = 6;
        double height = maxWidth > minWidth ? 50 : 33;
        double width = maxWidth > minWidth ? 40 : 23;
        return Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 1,
            spacing: 1,
            children: [
              for (int i = 0; i < 4; i++) ...[
                Container(
                  margin: EdgeInsets.all(margin),
                  child: Container(
                    height: height,
                    width: width,
                    color: AppColor.widgetBackground,
                    child: i < items.length
                        ? PresentImage(
                            path: items[i].child,
                          )
                        : Container(
                            height: height,
                            width: width,
                            color: AppColor.widgetBackgroundWithNothing,
                          ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
