import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

class ClothCard extends StatefulWidget {
  final String name;
  final ImageProvider otherProfileImage;
  final Widget content;
  final bool isSelectedToDelete;
  final bool isOtherProfile; // TODO: Change
  final bool isSelect;

  const ClothCard({
    super.key,
    required this.name,
    this.otherProfileImage = const AssetImage("assets/default_avatar.png"),
    required this.content,
    this.isSelectedToDelete = false,
    this.isOtherProfile = false,
    this.isSelect = false,
  });

  @override
  State<ClothCard> createState() => _ClothCardState();
}

class _ClothCardState extends State<ClothCard> {
  final Radius borderRadius = const Radius.circular(10);
  late bool isSelectedToDelete = widget.isSelectedToDelete;
  late bool isSelect = widget.isSelect;
  final double height = 218;
  final double width = 150;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppColor.maxWidthToImage) {
          return InkWell(
            onLongPress: () => {
              setState(
                () {
                  isSelect = !isSelect;
                },
              )
            },
            child: Stack(
              children: [
                CompactListItem(
                  widget: widget.content,
                  title: widget.name,
                  subTitle: '',
                  options: () => {
                    setState(() {
                      isSelectedToDelete = !isSelectedToDelete;
                    }),
                  },
                ),
                if (widget.isOtherProfile)
                  Positioned(
                    left: 46,
                    bottom: 4,
                    child: IconButtonRectangular(
                      dimension: 35,
                      object: Padding(
                        padding: const EdgeInsets.all(4),
                        child: PresentImage(
                          path: widget.otherProfileImage,
                        ),
                      ),
                    ),
                  ),
                if (isSelect)
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.widgetBackgroundBlurry,
                        borderRadius: BorderRadius.all(borderRadius),
                      ),
                      child: const Icon(
                        size: 50,
                        Icons.check_circle_outline_rounded,
                        color: AppColor.buttonBackground,
                      ),
                    ),
                  ),
                if (isSelectedToDelete)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: AppColor.buttonBackground,
                        borderRadius: BorderRadius.all(borderRadius),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColor.widgetBackground,
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return InkWell(
            onLongPress: () => {
              setState(() {
                isSelect = !isSelect;
              }),
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColor.widgetBackground,
                      borderRadius: BorderRadius.all(borderRadius),
                      boxShadow: const [AppColor.defaultShadow]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height - 44,
                              width: width - 6,
                              decoration: const BoxDecoration(
                                color: AppColor.widgetBackground,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [AppColor.defaultShadow],
                              ),
                              child: widget.content,
                            ),
                            Text(
                              widget.name,
                              style: AppText.smallHeader,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: AppColor.widgetSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        isSelectedToDelete = !isSelectedToDelete;
                      });
                    },
                  ),
                ),
                if (widget.isOtherProfile)
                  Positioned(
                    right: 16,
                    bottom: 54,
                    child: IconButtonRectangular(
                      dimension: 50,
                      object: Padding(
                        padding: const EdgeInsets.all(4),
                        child: PresentImage(
                          path: widget.otherProfileImage, //TODO: Change
                        ),
                      ),
                    ),
                  ),
                if (isSelect)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColor.widgetBackgroundBlurry,
                        borderRadius: BorderRadius.all(borderRadius),
                      ),
                      child: const Icon(
                        size: 100,
                        Icons.check_circle_outline_rounded,
                        color: AppColor.buttonBackground,
                      ),
                    ),
                  ),
                if (isSelectedToDelete)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 49,
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColor.buttonBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: borderRadius,
                          bottomRight: borderRadius,
                        ),
                        boxShadow: const [AppColor.defaultShadow],
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColor.widgetBackground,
                      ),
                    ),
                  )
              ],
            ),
          );
        }
      },
    );
  }
}
