import 'package:beat_ecoprove/client/clothing/contracts/cloth_result.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item_template.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

class ClothItem extends CardItemTemplate {
  final ImageProvider content;
  final ClothStates clothState;

  ClothItem({
    super.key,
    required this.clothState,
    required super.id,
    required this.content,
    required super.title,
    super.subTitle,
    super.otherProfileImage,
    super.isSelect,
    super.selectedIcon,
    super.isSelectedToDelete,
    required super.cardSelectedToDelete,
    super.cardType,
    required super.action,
    required super.buttonAction,
  });

  Widget extended(BuildContext context) {
    return PresentImage(
      path: content,
    );
  }

  Widget compact(BuildContext context) {
    return PresentImage(
      path: content,
    );
  }

  Widget createClothBody(BuildContext context, Types type) {
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
    return createClothBody(context, type);
  }
}
