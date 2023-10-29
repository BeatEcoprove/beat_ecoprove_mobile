import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

abstract class Header extends StatelessWidget implements PreferredSizeWidget {
  static const Radius borderRadius = Radius.circular(5);

  Widget body(BuildContext context);

  const Header({super.key});

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
            padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
            child: body(context),
          ),
        ),
      ),
    );
  }
}
