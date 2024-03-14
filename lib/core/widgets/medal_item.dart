import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_footer/without_options_footer/without_options_footer.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_header/image_title_subtitle_header.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item_root.dart';
import 'package:flutter/material.dart';

class MedalItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;

  const MedalItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: CompactListItemRoot(
        items: [
          ImageTitleSubtitleHeader(
            widget: icon,
            title: title,
            subTitle: subTitle,
          ),
          const WithoutOptionsFooter(),
        ],
      ),
    );
  }
}
