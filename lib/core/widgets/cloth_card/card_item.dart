import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
import 'package:beat_ecoprove/core/widgets/dialog_card.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

abstract class CardItemTemplate extends StatefulWidget {
  final String title;
  final String? subTitle;
  final ImageProvider? otherProfileImage;
  final bool isSelect;
  final bool isSelectedToDelete;
  final Function(CardItemTemplate)? selectionAction;
  final Function(CardItemTemplate)? removeAction;

  const CardItemTemplate({
    Key? key,
    required this.title,
    this.subTitle,
    this.isSelect = false,
    this.isSelectedToDelete = false,
    this.otherProfileImage,
    this.selectionAction,
    this.removeAction,
  }) : super(key: key);

  Widget body(BuildContext context);

  void handleSelection() {
    if (selectionAction != null) {
      selectionAction!(this);
    }
  }

  void handleRemove() {
    if (removeAction != null) {
      removeAction!(this);
    }
  }

  @override
  State<CardItemTemplate> createState() => _CardItemTemplateState();
}

class _CardItemTemplateState extends State<CardItemTemplate> {
  late bool _isSelectedToDelete = widget.isSelectedToDelete;
  late bool _isSelect = widget.isSelect;

  void toggleSelectedToDelete() {
    setState(() {
      _isSelectedToDelete = !_isSelectedToDelete;
    });
  }

  void select() {
    setState(() {
      _isSelect = !_isSelect;
      _isSelectedToDelete = false;
      widget.handleSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        Radius borderRadius = const Radius.circular(10);
        return InkWell(
          onLongPress: select,
          child: Stack(
            children: [
              _defineListItem(constraints, context),
              if (maxWidth > AppColor.maxWidthToImageWithMediaQueryCards)
                Positioned(
                  top: 10,
                  right: 4,
                  child: IconButton(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: AppColor.widgetSecondary,
                    ),
                    onPressed: toggleSelectedToDelete,
                  ),
                ),
              if (widget.otherProfileImage != null)
                Positioned(
                  left: maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                      ? null
                      : 46,
                  right: maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                      ? 16
                      : null,
                  bottom: maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                      ? 54
                      : 4,
                  child: IconButtonRectangular(
                    dimension:
                        maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                            ? 50
                            : 35,
                    object: Padding(
                      padding: const EdgeInsets.all(4),
                      child: PresentImage(
                        path: widget.otherProfileImage!,
                      ),
                    ),
                  ),
                ),
              if (_isSelectedToDelete)
                Positioned(
                  left: maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                      ? null
                      : 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      _removeCard(
                        context,
                        _removedCardVersion(widget),
                      );
                    },
                    child: Container(
                      height:
                          maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                              ? 49
                              : 75,
                      width:
                          maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                              ? 150
                              : 75,
                      decoration: BoxDecoration(
                        color: AppColor.buttonBackground,
                        borderRadius: maxWidth >
                                AppColor.maxWidthToImageWithMediaQueryCards
                            ? BorderRadius.only(
                                bottomLeft: borderRadius,
                                bottomRight: borderRadius)
                            : BorderRadius.all(borderRadius),
                        boxShadow: const [AppColor.defaultShadow],
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: AppColor.widgetBackground,
                      ),
                    ),
                  ),
                ),
              if (_isSelect)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColor.widgetBackgroundBlurry,
                      borderRadius: AppColor.borderRadius,
                    ),
                    child: Icon(
                      size:
                          maxWidth > AppColor.maxWidthToImageWithMediaQueryCards
                              ? 100
                              : 50,
                      Icons.check_circle_outline_rounded,
                      color: AppColor.buttonBackground,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _removeCard(BuildContext context, Widget card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCard(
          card: card,
          text: "Tem a certeza que pretende remover esta peça de roupa?",
          firstAction: () {
            widget.handleRemove();
          },
          secondAction: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _removedCardVersion(CardItemTemplate card) {
    if (card is Bucket) {
      return ExtendedItem(
        content: ExtendedBucket(items: card.items).build(context),
        title: card.title,
        otherProfileImage: card.otherProfileImage,
      );
    }
    return ExtendedItem(
      content: card.body(context),
      title: card.title,
      otherProfileImage: card.otherProfileImage,
    );
  }

  Widget _defineListItem(BoxConstraints constraints, BuildContext context) {
    if (constraints.maxWidth < AppColor.maxWidthToImage) {
      return CompactListItem(
          widget: widget.body(context),
          title: widget.title,
          subTitle: widget.subTitle ?? '',
          options: toggleSelectedToDelete);
    }

    return ExtendedItem(
      content: widget.body(context),
      title: widget.title,
    );
  }
}

class ExtendedItem extends StatelessWidget {
  final Widget content;
  final String title;
  final ImageProvider? otherProfileImage;

  const ExtendedItem({
    super.key,
    required this.content,
    required this.title,
    this.otherProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 218;
    const double width = 150;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: AppColor.widgetBackground,
              borderRadius: AppColor.borderRadius,
              boxShadow: [AppColor.defaultShadow]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: height - 44,
                width: width - 6,
                decoration: const BoxDecoration(
                  color: AppColor.widgetBackground,
                  borderRadius: AppColor.borderRadius,
                  boxShadow: [AppColor.defaultShadow],
                ),
                child: content,
              ),
              Text(
                title,
                style: AppText.smallHeader,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (otherProfileImage != null)
          Positioned(
            right: 16,
            bottom: 54,
            child: IconButtonRectangular(
              dimension: 50,
              object: Padding(
                padding: const EdgeInsets.all(4),
                child: PresentImage(
                  path: otherProfileImage!,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
