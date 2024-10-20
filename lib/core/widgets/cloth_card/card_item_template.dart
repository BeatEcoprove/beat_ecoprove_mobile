import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:beat_ecoprove/core/widgets/dialog_card.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

abstract class CardItemTemplate extends StatefulWidget {
  final Function(String) cardSelectedToDelete;
  final String id;
  final String title;
  final String? subTitle;
  final ImageProvider? otherProfileImage;
  final bool isSelect;
  final IconData selectedIcon;
  final bool isSelectedToDelete;
  final Types? cardType;
  final String action;
  final Function(List<String>)? buttonAction;

  CardItemTemplate({
    Key? key,
    required this.id,
    required this.title,
    this.subTitle,
    this.isSelect = false,
    this.selectedIcon = Icons.check_circle_outline_rounded,
    this.isSelectedToDelete = false,
    this.otherProfileImage,
    required this.cardSelectedToDelete,
    this.cardType,
    required this.action,
    this.buttonAction,
  }) : super(key: key);

  Widget body(BuildContext context, Types type);

  final GlobalKey _buttonKey = GlobalKey();

  @override
  State<CardItemTemplate> createState() => _CardItemTemplateState();
}

class _CardItemTemplateState extends State<CardItemTemplate> {
  late bool _isSelectedToDelete = widget.isSelectedToDelete;
  late List<OptionItem> options;

  Positioned _allSpaceFromCard() {
    return Positioned.fill(
        child: Container(
      color: Colors.transparent,
    ));
  }

  Positioned _otherProfileImageWidget(
    double dimensionContent,
    double? left,
    double? right,
    double bottom,
  ) {
    return Positioned(
      left: left,
      right: right,
      bottom: bottom,
      child: IconButtonRectangular(
          dimension: dimensionContent,
          object: PresentImage(
            path: widget.otherProfileImage!,
          )),
    );
  }

  void _removeCard(BuildContext context, Widget card, String id) {
    double extraDistance = widget.otherProfileImage != null ? 52 : 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCard(
          card: Stack(children: [
            _baseCardItemTemplate(),
            if (widget.otherProfileImage != null)
              _otherProfileImageWidget(50, null, 16, 54),
            if (isClothInUse()) _inUseBadge(35, null, 16, 54 + extraDistance),
          ]),
          text: "Tem a certeza que pretende remover esta peça de roupa?",
          firstAction: () {
            widget.cardSelectedToDelete(id);
            Navigator.of(context).pop();
          },
          secondAction: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Positioned _selectedToDeleteButton(
    double? left,
    double heightContainer,
    double widthContainer,
    bool hasTopBorder,
  ) {
    Radius borderRadius = const Radius.circular(5);

    return Positioned(
      left: left,
      bottom: 0,
      child: InkWell(
        onTap: () {
          _removeCard(
            context,
            widget,
            widget.id,
          );
        },
        child: Container(
          height: heightContainer,
          width: widthContainer,
          decoration: BoxDecoration(
            color: AppColor.buttonBackground,
            borderRadius: BorderRadius.only(
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
              topLeft: hasTopBorder ? borderRadius : Radius.zero,
              topRight: hasTopBorder ? borderRadius : Radius.zero,
            ),
            boxShadow: const [AppColor.defaultShadow],
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: AppColor.widgetBackground,
          ),
        ),
      ),
    );
  }

  Positioned _selectionCheck(double size, IconData icon) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.widgetBackgroundBlurry,
          borderRadius: AppColor.borderRadius,
        ),
        child: Icon(
          size: size,
          icon,
          color: AppColor.buttonBackground,
        ),
      ),
    );
  }

  Widget compact(BoxConstraints constraints, BuildContext context) {
    double extraDistance = widget.otherProfileImage != null ? 18 : 0;
    return Stack(
      children: [
        CompactListItemRoot(
          items: [
            ImageTitleSubtitleHeader(
              widget: widget.body(context, Types.compact),
              title: widget.title,
              subTitle: widget.subTitle ?? '',
              withoutBoxShadow: true,
            ),
            const WithoutOptionsFooter(),
          ],
        ),
        if (widget.otherProfileImage != null)
          _otherProfileImageWidget(35, 46, null, 4),
        if (isClothInUse()) _inUseBadge(18, 58 + extraDistance, null, 4),
        _allSpaceFromCard(),
        if (widget.id != "outfit") _actionsWidget(16, widget.action),
        if (_isSelectedToDelete) _selectedToDeleteButton(0, 75, 75, true),
        if (widget.isSelect) _selectionCheck(50, widget.selectedIcon),
      ],
    );
  }

  Container _baseCardItemTemplate() {
    const double height = 218;
    const double width = 150;

    return Container(
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
          SizedBox(
            height: height - 44,
            width: width - 6,
            child: widget.body(context, Types.extended),
          ),
          Text(
            widget.title,
            style: AppText.smallHeader,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    final RenderBox buttonRenderBox =
        widget._buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy,
        buttonPosition.dx + buttonRenderBox.size.width,
        buttonPosition.dy + buttonRenderBox.size.height,
      ),
      items: options.map((option) {
        return PopupMenuItem(
          onTap: option.action,
          child: Text(option.name),
        );
      }).toList(),
    );
  }

  Positioned _actionsWidget(double top, String action) {
    return Positioned(
      top: top,
      right: 4,
      child: IconButton(
        key: widget._buttonKey,
        icon: const Icon(
          Icons.more_vert_rounded,
          color: AppColor.widgetSecondary,
        ),
        onPressed: () {
          switch (action) {
            case "remove":
              setState(() {
                _isSelectedToDelete = !_isSelectedToDelete;
              });
              break;
            case "removeFromBucket":
              _showOptionsMenu(context);
              break;
          }
        },
      ),
    );
  }

  Positioned _inUseBadge(
    double dimensionContent,
    double? left,
    double? right,
    double bottom,
  ) {
    return Positioned(
        left: left,
        right: right,
        bottom: bottom,
        child: IconButtonRectangular(
          isCircular: true,
          colorBackground: AppColor.buttonBackground,
          dimension: dimensionContent,
          object: Icon(
            Icons.directions_walk_rounded,
            size: dimensionContent / 1.5,
            color: AppColor.widgetBackground,
          ),
        ));
  }

  Widget extended(BoxConstraints constraints, BuildContext context) {
    double extraDistance = widget.otherProfileImage != null ? 52 : 0;
    return Stack(
      children: [
        _baseCardItemTemplate(),
        if (widget.otherProfileImage != null)
          _otherProfileImageWidget(50, null, 16, 54),
        if (isClothInUse()) _inUseBadge(35, null, 16, 54 + extraDistance),
        _allSpaceFromCard(),
        if (widget.id != "outfit") _actionsWidget(10, widget.action),
        if (_isSelectedToDelete) _selectedToDeleteButton(null, 49, 150, false),
        if (widget.isSelect) _selectionCheck(100, widget.selectedIcon),
      ],
    );
  }

  bool isClothInUse() {
    return widget is ClothItem &&
        (widget as ClothItem).clothState == ClothStates.inUse;
  }

  Widget _createCard(
      BoxConstraints constraints, BuildContext context, Types type) {
    switch (type) {
      case Types.extended:
        return extended(constraints, context);
      case Types.compact:
        return compact(constraints, context);
      default:
        return extended(constraints, context);
    }
  }

  Widget _defineListItem(
      BoxConstraints constraints, BuildContext context, Types? cardType) {
    if (cardType != null) {
      return _createCard(constraints, context, cardType);
    } else {
      if (constraints.maxWidth < AppColor.maxWidthToImage) {
        return _createCard(constraints, context, Types.compact);
      } else {
        return _createCard(constraints, context, Types.extended);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    options = [
      OptionItem(
        name: 'Remover',
        action: () => {
          if (widget.buttonAction != null)
            {
              widget.buttonAction!([widget.id]),
            }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _defineListItem(constraints, context, widget.cardType);
      },
    );
  }
}

enum Types {
  extended,
  compact,
}
