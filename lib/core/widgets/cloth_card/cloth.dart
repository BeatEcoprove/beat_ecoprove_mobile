import 'package:beat_ecoprove/core/widgets/cloth_card/card_item.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:flutter/material.dart';

class Cloth extends CardItemTemplate {
  final ImageProvider content;

  const Cloth({
    super.key,
    required this.content,
    required super.title,
    super.otherProfileImage,
    super.selectionAction,
    super.removeAction,
  });

  @override
  Widget body(BuildContext context) {
    return PresentImage(
      path: content,
    );
  }
}
