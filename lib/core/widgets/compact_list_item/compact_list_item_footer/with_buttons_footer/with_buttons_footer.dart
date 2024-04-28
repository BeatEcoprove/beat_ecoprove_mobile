import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_buttons_footer/i_with_buttons_footer.dart';
import 'package:flutter/material.dart';

class WithButtonsFooter extends IWithButtonsFooter {
  const WithButtonsFooter({
    super.key,
    required super.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: options.map((option) {
          return IconButton(
            onPressed: option.action,
            icon: option.icon,
          );
        }).toList(),
      ),
    );
  }
}
