import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item_template.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class BucketItem extends CardItemTemplate {
  final List<CardItem> items;

  BucketItem({
    super.key,
    required super.id,
    required this.items,
    required super.title,
    super.otherProfileImage,
    super.isSelect,
    super.isSelectedToDelete,
    required super.cardSelectedToDelete,
    super.cardType,
    required super.action,
  });

  Container _itemGrid(
    double margin,
    double height,
    double width,
    int i,
  ) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Container(
        height: height,
        width: width,
        color: AppColor.widgetBackground,
        child: i < items.length
            ? PresentImage(
                path: ServerImage(items[i].child),
              )
            : Container(
                height: height,
                width: width,
                color: AppColor.widgetBackgroundWithNothing,
              ),
      ),
    );
  }

  Widget compact(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = MediaQuery.of(context).size.width;

        return Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 1,
            spacing: 1,
            children: [
              for (int i = 0; i < 4; i++) ...[
                if (maxWidth < AppColor.maxWidthToImageWithMediaQueryCards) ...{
                  _itemGrid(4, 15, 15, i),
                } else ...{
                  _itemGrid(6, 50, 40, i),
                }
              ],
            ],
          ),
        );
      },
    );
  }

  Widget extended(BuildContext context) {
    double minWidth = 273;
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = MediaQuery.of(context).size.width;
        return Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 1,
            spacing: 1,
            children: [
              for (int i = 0; i < 4; i++) ...[
                if (maxWidth > minWidth) ...{
                  _itemGrid(6, 50, 40, i),
                } else ...{
                  _itemGrid(6, 33, 23, i)
                }
              ],
            ],
          ),
        );
      },
    );
  }

  Widget createBucketBody(BuildContext context, Types type) {
    switch (type) {
      case Types.extended:
        return extended(context);
      case Types.compact:
        return compact(context);
      default:
        return extended(context);
    }
  }

  @override
  Widget body(BuildContext context, Types type) {
    return createBucketBody(context, type);
  }
}
