import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/order_card/order_card_item.dart';
import 'package:flutter/material.dart';

class OrderCardRoot extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final List<OrderCardItem> items;

  final VoidCallback? click;
  final VoidCallback? longPress;

  final double padding;

  const OrderCardRoot({
    super.key,
    required this.items,
    this.padding = 8,
    this.click,
    this.longPress,
  });

  @override
  Widget build(BuildContext context) {
    if (click != null) {
      return InkWell(
        onTap: click,
        onLongPress: longPress,
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
