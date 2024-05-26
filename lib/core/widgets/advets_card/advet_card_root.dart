import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/advets_card/advet_card_item.dart';
import 'package:flutter/material.dart';

class AdvertCardRoot extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final List<AdvertCardItem> items;

  final VoidCallback? click;

  final double padding;

  const AdvertCardRoot({
    super.key,
    required this.items,
    this.padding = 8,
    this.click,
  });

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
    double maxWidth = MediaQuery.of(context).size.width - 12;

    return Container(
      padding: EdgeInsets.all(padding),
      width: maxWidth,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items,
        ),
      ),
    );
  }
}
