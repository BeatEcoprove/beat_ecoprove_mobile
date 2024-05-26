import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advet_card_item.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/with_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:flutter/material.dart';

class AdvertHeader extends AdvertCardItem {
  final Widget widget;
  final String title;
  final String subTitle;
  final bool isCircular;
  final bool withoutBoxShadow;
  final String contentText;
  final String contentSubText;
  final List<OptionItem> options;

  const AdvertHeader({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.contentText,
    required this.contentSubText,
    required this.options,
    this.isCircular = false,
    this.withoutBoxShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    double extraPadding = 8;
    double imageSize = 60;
    double optionsSize = 32;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 68,
                    child: Row(
                      children: [
                        IconButtonRectangular(
                          isCircular: isCircular,
                          dimension: imageSize,
                          object: widget,
                          withoutBoxShadow: withoutBoxShadow,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth -
                                  imageSize -
                                  optionsSize -
                                  (extraPadding * 2),
                              child: Text(
                                title,
                                style: AppText.titleToScrollSection,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth -
                                  imageSize -
                                  optionsSize -
                                  (extraPadding * 2),
                              child: Text(
                                subTitle,
                                style: AppText.subHeader,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: optionsSize,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: optionsSize,
                                child: Container(),
                              ),
                              WithOptionsFooter(options: options),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: Line(
                      width: constraints.maxWidth - 40,
                      color: AppColor.separatedLine,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth - (extraPadding * 2),
                        child: Text(
                          contentText,
                          style: AppText.smallHeader,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth - (extraPadding * 2),
                        child: Text(
                          contentSubText,
                          maxLines: 5,
                          style: AppText.smallSubHeader,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
