import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class AdvertisementCard extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(5);

  final Widget widget;
  final Widget cardContext;

  const AdvertisementCard({
    super.key,
    required this.widget,
    required this.cardContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsetsDirectional.only(start: 12, end: 12),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [AppColor.defaultShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (MediaQuery.of(context).size.width > AppColor.maxWidthToImage)
            Container(
                width: 136,
                height: 196,
                decoration: const BoxDecoration(
                    color: AppColor.widgetBackground,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [AppColor.defaultShadow]),
                child: widget),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Container(color: Colors.transparent),
          ),
          Expanded(
            child: cardContext,
          ),
        ],
      ),
    );
  }
}
