import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/with_options_footer/i_with_options_footer.dart';
import 'package:flutter/material.dart';

class WithOptionsAndTextFooter extends IWithOptionsFooter {
  final String text;

  WithOptionsAndTextFooter({
    super.key,
    required super.options,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 60,
        ),
        Positioned(
          right: 0,
          child: InkWell(
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
          ),
        ),
        Positioned(
          bottom: 6,
          width: 65,
          child: Text(
            text,
            style: AppText.subHeader,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
