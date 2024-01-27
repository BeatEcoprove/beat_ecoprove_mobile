import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/headers/header.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class StandardHeader extends Header {
  final VoidCallback? helpPress;
  final VoidCallback? settingsPress;

  final bool hasSustainablePoints;
  final int sustainablePoints;
  final bool hasSettings;
  final bool hasSearchBar;
  final String title;
  final Function(String)? onChange;
  final String initialValue;
  final String errorMessage;

  const StandardHeader({
    this.title = '',
    this.hasSustainablePoints = true,
    this.hasSettings = false,
    this.hasSearchBar = false,
    this.helpPress,
    this.settingsPress,
    required this.sustainablePoints,
    this.onChange,
    super.key,
  })  : initialValue = '',
        errorMessage = '';

  const StandardHeader.searchBar({
    this.title = '',
    this.hasSustainablePoints = true,
    this.hasSettings = false,
    this.hasSearchBar = true,
    required this.onChange,
    required this.initialValue,
    required this.errorMessage,
    this.helpPress,
    this.settingsPress,
    required this.sustainablePoints,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      hasSearchBar ? const Size.fromHeight(96 + 58) : const Size.fromHeight(96);

  @override
  Widget body(BuildContext context) {
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
                    child: Points.sustainablePoints(points: sustainablePoints),
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
        if (hasSearchBar)
          Column(
            children: [
              DefaultFormattedTextField(
                hintText: "Pesquisar",
                leftIcon: const Icon(Icons.search_rounded),
                onChange: onChange,
                initialValue: initialValue,
                errorMessage: errorMessage,
              ),
            ],
          ),
      ],
    );
  }
}
