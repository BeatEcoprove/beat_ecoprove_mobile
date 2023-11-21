import 'package:beat_ecoprove/core/widgets/cloth_card/card_item.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

class ClothItem extends CardItemTemplate {
  final NetworkImage content;

  const ClothItem({
    super.key,
    required this.content,
    required super.title,
    super.otherProfileImage,
    super.isSelect,
    super.isSelectedToDelete,
    required super.cardSelectedToDelete,
  });

  @override
  Widget body(BuildContext context) {
    return PresentImage(
      path: content,
    );
  }
}
