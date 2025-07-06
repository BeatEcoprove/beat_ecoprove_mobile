import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

abstract class Header extends StatelessWidget implements PreferredSizeWidget {
  static const Radius borderRadius = Radius.circular(5);
  final double paddingHorizontal;
  final double topPadding;
  final double bottomPadding;

  Widget body(BuildContext context);

  const Header({
    super.key,
    this.paddingHorizontal = 16,
    this.topPadding = 48,
    this.bottomPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: AppColor.widgetBackground,
              borderRadius: BorderRadius.only(
                  bottomLeft: borderRadius, bottomRight: borderRadius),
              boxShadow: [AppColor.defaultShadow]),
          child: Padding(
            padding: EdgeInsets.only(
                top: topPadding,
                bottom: bottomPadding,
                left: paddingHorizontal,
                right: paddingHorizontal),
            child: body(context),
          ),
        ),
      ),
    );
  }
}
