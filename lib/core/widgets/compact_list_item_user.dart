import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:flutter/material.dart';

class CompactListItemUser extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final List<OptionItem>? options;
  final VoidCallback? click;

  final String title;
  final int userLevel;
  final int sustainablePoints;
  final int ecoScorePoints;
  final bool withoutBoxShadow;
  final bool hasOptions;

  CompactListItemUser({
    super.key,
    required this.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.withoutBoxShadow = false,
    required this.options,
    this.hasOptions = true,
  }) : click = null;

  CompactListItemUser.withoutOptions({
    super.key,
    required this.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.withoutBoxShadow = false,
    this.hasOptions = false,
  })  : click = null,
        options = null;

  CompactListItemUser.open({
    super.key,
    required this.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.withoutBoxShadow = false,
    required this.options,
    this.hasOptions = true,
    required this.click,
  });

  @override
  Widget build(BuildContext context) {
    if (click != null) {
      return InkWell(
        child: body(context),
        onTap: click,
      );
    }

    return body(context);
  }

  final GlobalKey _buttonKey = GlobalKey();

  Widget body(BuildContext context) {
    const double height = 88;

    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 70,
            height: height,
            decoration: const BoxDecoration(
              color: AppColor.darkGreen,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
                bottomLeft: borderRadius,
                topLeft: borderRadius,
              ),
              boxShadow: [AppColor.defaultShadow],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nível",
                  style: AppText.textButton,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  userLevel.toString(),
                  style: AppText.firstHeaderWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: AppText.headerBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Points.sustainablePoints(
                      points: sustainablePoints,
                    ),
                    Points.ecoScore(points: ecoScorePoints),
                  ],
                )
              ],
            ),
          ),
          if (hasOptions)
            InkWell(
              key: _buttonKey,
              onTap: () {
                _showOptionsMenu(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColor.widgetSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    final RenderBox buttonRenderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy,
        buttonPosition.dx + buttonRenderBox.size.width,
        buttonPosition.dy + buttonRenderBox.size.height,
      ),
      items: options!.map((option) {
        return PopupMenuItem(
          onTap: option.action,
          child: Text(option.name),
        );
      }).toList(),
    );
  }
}
