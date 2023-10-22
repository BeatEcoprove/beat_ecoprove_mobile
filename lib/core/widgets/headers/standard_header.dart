import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/headers/headers.dart';
import 'package:beat_ecoprove/core/widgets/sustainable_points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class StandardHeader extends StatelessWidget implements Headers {
  final VoidCallback? helpPress;
  final VoidCallback? settingsPress;

  final bool hasSustainablePoints;
  final int sustainablePoints;
  final bool hasSettings;
  final String title;

  const StandardHeader({
    this.title = '',
    this.hasSustainablePoints = true,
    this.hasSettings = false,
    this.helpPress,
    this.settingsPress,
    required this.sustainablePoints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title.isEmpty)
              const SvgImage(
                path: "assets/applicationTitle.svg",
                height: 68.23,
                width: 150.36,
              ),
            if (title.isNotEmpty)
              Expanded(
                child: Text(
                  title,
                  style: AppText.firstHeader,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (hasSustainablePoints && title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child:
                        SustainablePoints(sustainablePoints: sustainablePoints),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(
                      Icons.help_outline_rounded,
                      color: AppColor.helpGreen,
                    ),
                    onPressed: helpPress,
                  ),
                ),
                if (hasSettings)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IconButton(
                      iconSize: 20,
                      icon: const Icon(
                        Icons.settings,
                        color: AppColor.black,
                      ),
                      onPressed: settingsPress,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
