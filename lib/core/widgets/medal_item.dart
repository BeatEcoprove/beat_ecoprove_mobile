import 'package:beat_ecoprove/core/widgets/compact_list_item.dart';
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
      child: CompactListItem.withoutOptions(
        widget: icon,
        title: title,
        subTitle: subTitle,
      ),
    );
  }
}
