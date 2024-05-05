import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/i_without_options_footer.dart';
import 'package:flutter/material.dart';

class WithTextFooter extends IWithoutOptionsFooter {
  final String text;

  const WithTextFooter({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width * (1 / 3) - 64;

    return Stack(
      children: [
        Container(
          width: maxWidth,
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
