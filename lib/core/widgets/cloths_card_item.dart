import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:flutter/material.dart';

class ClothsCardItem extends StatefulWidget {
  final String name;
  final Widget image;
  final bool isSelectedToDelete;
  final bool isOtherProfile; // TODO: Change

  const ClothsCardItem({
    super.key,
    required this.name,
    required this.image,
    this.isSelectedToDelete = false,
    this.isOtherProfile = false,
  });

  @override
  State<ClothsCardItem> createState() => _ClothsCardItemState();
}

class _ClothsCardItemState extends State<ClothsCardItem> {
  static const Radius borderRadius = Radius.circular(10);

  late bool isSelectedToDelete = widget.isSelectedToDelete;
  final double height = 218;
  final double width = 150;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width <= AppColor.maxWidthToImage) {
      return Stack(
        children: [
          CompactListItem(
              widget: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  "assets/default_avatar.png", //TODO: Change
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
              title: widget.name,
              subTitle: '',
              options: () => {
                    setState(() {
                      isSelectedToDelete = !isSelectedToDelete;
                    }),
                  }),
          if (widget.isOtherProfile)
            Positioned(
              left: 46,
              bottom: 4,
              child: IconButtonRectangular(
                dimension: 35,
                object: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(
                    "assets/default_avatar.png", //TODO: Change
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
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
                decoration: const BoxDecoration(
                  color: AppColor.buttonBackground,
                  borderRadius: BorderRadius.all(borderRadius),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColor.widgetBackground,
                ),
              ),
            )
        ],
      );
    }

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: AppColor.widgetBackground,
              borderRadius: BorderRadius.all(borderRadius),
              boxShadow: [AppColor.defaultShadow]),
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [AppColor.defaultShadow],
                        ),
                        child: widget.image),
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
                child: Image.asset(
                  "assets/default_avatar.png", //TODO: Change
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        if (isSelectedToDelete)
          Positioned(
            bottom: 0,
            child: Container(
              height: 49,
              width: width,
              decoration: const BoxDecoration(
                color: AppColor.buttonBackground,
                borderRadius: BorderRadius.only(
                  bottomLeft: borderRadius,
                  bottomRight: borderRadius,
                ),
                boxShadow: [AppColor.defaultShadow],
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColor.widgetBackground,
              ),
            ),
          )
      ],
    );
  }
}
