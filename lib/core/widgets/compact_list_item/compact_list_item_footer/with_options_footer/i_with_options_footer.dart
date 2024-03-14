import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/compact_list_item_footer.dart';
import 'package:flutter/material.dart';

abstract class IWithOptionsFooter extends CompactListItemFooter {
  final List<OptionItem> options;

  IWithOptionsFooter({
    super.key,
    required this.options,
  });

  final GlobalKey buttonKey = GlobalKey();

  void showOptionsMenu(BuildContext context) {
    final RenderBox buttonRenderBox =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
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
}
