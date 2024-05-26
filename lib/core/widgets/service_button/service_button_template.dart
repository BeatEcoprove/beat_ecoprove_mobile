import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

abstract class ServiceButtonTemplate extends StatelessWidget {
  final double dimension;
  final Color colorBackground;
  final Color colorBorder;
  final Color colorForeground;
  final Widget object;
  final String title;

  const ServiceButtonTemplate({
    super.key,
    required this.dimension,
    required this.colorBackground,
    required this.colorBorder,
    required this.colorForeground,
    required this.object,
    required this.title,
  });

  Widget body() {
    const Radius borderRadius = Radius.circular(5);
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: colorBackground,
        border: Border.all(
          color: colorBorder,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(borderRadius),
        boxShadow: const [AppColor.defaultShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: dimension - 50,
              alignment: Alignment.center,
              child: object,
            ),
            Text(
              title,
              style: AppText.strongCustomStyle(colorForeground),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context);
}
