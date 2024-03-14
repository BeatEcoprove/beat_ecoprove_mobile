import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/i_with_options_footer.dart';
import 'package:flutter/material.dart';

class WithOptionsFooter extends IWithOptionsFooter {
  WithOptionsFooter({
    super.key,
    required super.options,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: super.buttonKey,
      onTap: () {
        super.showOptionsMenu(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.more_vert_rounded,
          color: AppColor.widgetSecondary,
        ),
      ),
    );
  }
}
