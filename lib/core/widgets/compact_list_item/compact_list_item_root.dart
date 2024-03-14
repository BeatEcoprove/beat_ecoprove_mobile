import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/compact_list_item/compact_list_item.dart';
import 'package:flutter/material.dart';

enum Padding implements Comparable<Padding> {
  padding8(value: 8),
  padding0(value: 0);

  final double value;
  const Padding({required this.value});

  @override
  int compareTo(Padding other) {
    throw UnimplementedError();
  }
}

enum HeightCard implements Comparable<HeightCard> {
  height75(value: 75),
  height88(value: 88);

  final double value;
  const HeightCard({required this.value});

  @override
  int compareTo(HeightCard other) {
    throw UnimplementedError();
  }
}

class CompactListItemRoot extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final List<CompactListItem> items;

  final VoidCallback? click;

  final Padding padding;
  final HeightCard height;

  const CompactListItemRoot({
    super.key,
    required this.items,
    this.padding = Padding.padding8,
    this.height = HeightCard.height75,
  }) : click = null;

  @override
  Widget build(BuildContext context) {
    if (click != null) {
      return InkWell(
        onTap: click,
        child: body(context),
      );
    }

    return body(context);
  }

  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.value),
      height: height.value,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }
}
