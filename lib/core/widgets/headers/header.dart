import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/headers/headers.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  static const Radius borderRadius = Radius.circular(5);

  final Headers content;

  const Header({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: content.preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: AppColor.widgetBackground,
              borderRadius: BorderRadius.only(
                  bottomLeft: borderRadius, bottomRight: borderRadius),
              boxShadow: [AppColor.defaultShadow]),
          child: Padding(
              padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
              child: content),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => content.preferredSize;
}
