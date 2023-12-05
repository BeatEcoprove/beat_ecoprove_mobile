import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
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
  final bool isSelectedToDelete;

  const CardItemTemplate({
    Key? key,
    required this.id,
    required this.title,
    this.subTitle,
    this.isSelect = false,
    this.isSelectedToDelete = false,
    this.otherProfileImage,
    required this.cardSelectedToDelete,
  }) : super(key: key);

  Widget body(BuildContext context, Types type);

  @override
  State<CardItemTemplate> createState() => _CardItemTemplateState();
}

class _CardItemTemplateState extends State<CardItemTemplate> {
  late bool _isSelectedToDelete = widget.isSelectedToDelete;

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
        object: Padding(
          padding: const EdgeInsets.all(4),
          child: PresentImage(
            path: widget.otherProfileImage!,
          ),
        ),
      ),
    );
  }

  void _removeCard(BuildContext context, Widget card, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCard(
          card: _baseCardItemTemplate(),
          text: "Tem a certeza que pretende remover esta peça de roupa?",
          firstAction: () {
            widget.cardSelectedToDelete(id);
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

  Positioned _selectionCheck(double size) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.widgetBackgroundBlurry,
          borderRadius: AppColor.borderRadius,
        ),
        child: Icon(
          size: size,
          Icons.check_circle_outline_rounded,
          color: AppColor.buttonBackground,
        ),
      ),
    );
  }

  Widget compact(BoxConstraints constraints, BuildContext context) {
    return Stack(
      children: [
        CompactListItem(
          widget: widget.body(context, Types.compact),
          title: widget.title,
          subTitle: widget.subTitle ?? '',
          options: () {
            setState(() {
              _isSelectedToDelete = !_isSelectedToDelete;
            });
          },
        ),
        if (widget.otherProfileImage != null)
          _otherProfileImageWidget(35, 46, null, 4),
        if (_isSelectedToDelete) _selectedToDeleteButton(0, 75, 75, true),
        if (widget.isSelect) _selectionCheck(50),
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

  Positioned _actionsWidget() => Positioned(
        top: 10,
        right: 4,
        child: IconButton(
          icon: const Icon(
            Icons.more_vert_rounded,
            color: AppColor.widgetSecondary,
          ),
          onPressed: () {
            setState(() {
              _isSelectedToDelete = !_isSelectedToDelete;
            });
          },
        ),
      );

  Widget extended(BoxConstraints constraints, BuildContext context) {
    return Stack(
      children: [
        _baseCardItemTemplate(),
        _actionsWidget(),
        if (widget.otherProfileImage != null)
          _otherProfileImageWidget(50, null, 16, 54),
        if (_isSelectedToDelete) _selectedToDeleteButton(null, 49, 150, false),
        if (widget.isSelect) _selectionCheck(100),
      ],
    );
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

  Widget _defineListItem(BoxConstraints constraints, BuildContext context) {
    if (constraints.maxWidth < AppColor.maxWidthToImage) {
      return _createCard(constraints, context, Types.compact);
    } else {
      return _createCard(constraints, context, Types.extended);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _defineListItem(constraints, context);
      },
    );
  }
}

enum Types {
  extended,
  compact,
}
