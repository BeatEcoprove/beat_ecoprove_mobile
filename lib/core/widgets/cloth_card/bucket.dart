import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cardItem.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

class CardItemModel {
  final String title;
  final String? subTitle;
  final ImageProvider image;

  CardItemModel({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class Bucket extends CardItemTemplate {
  final List<CardItemModel> items;

  const Bucket({
    super.key,
    required this.items,
    required super.title,
    super.otherProfileImage,
    super.selectionAction,
  });

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = MediaQuery.of(context).size.width;
        double margin =
            maxWidth < AppColor.maxWidthToImageWithMediaQuery ? 4 : 6;
        double height =
            maxWidth < AppColor.maxWidthToImageWithMediaQuery ? 20 : 50;
        double width =
            maxWidth < AppColor.maxWidthToImageWithMediaQuery ? 20 : 40;
        return Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 1,
            spacing: 1,
            children: [
              for (int i = 0; useFourItemsImagesToBucket(i); i++) ...[
                Container(
                  margin: EdgeInsets.all(margin),
                  child: Container(
                    height: height,
                    width: width,
                    color: AppColor.widgetBackground,
                    child: PresentImage(
                      path: items[i].image,
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

  bool useFourItemsImagesToBucket(int i) => i < items.length && i < 4;
}
