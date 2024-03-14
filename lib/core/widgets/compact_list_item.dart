import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompactListItem extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final List<OptionItem>? options;
  final VoidCallback? click;

  final List<String>? dropOptions;
  final String? dropOptionsValue;
  final Function(String)? dropOptionsSet;
  final String? workerType;

  late double padding = 8;
  static const double heightDefaultCard = 75;
  static const double heightUserCard = 88;

  late double height = heightDefaultCard;
  final Widget? widget;
  final String title;
  final String? subTitle;
  final bool? isCircular;
  final bool withoutBoxShadow;
  final String? secondSubText;
  final String typeStart;
  final String typeEnd;

  final int? userLevel;
  final int? sustainablePoints;
  final int? ecoScorePoints;
  final bool? hasBorder;

  CompactListItem({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    required this.options,
  })  : typeStart = 'default',
        typeEnd = 'default',
        secondSubText = null,
        click = null,
        userLevel = null,
        sustainablePoints = null,
        ecoScorePoints = null,
        hasBorder = null,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.withoutOptions({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
  })  : typeStart = 'default',
        typeEnd = 'withoutOptions',
        secondSubText = null,
        options = null,
        click = null,
        userLevel = null,
        sustainablePoints = null,
        ecoScorePoints = null,
        hasBorder = null,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.withSecondSubText({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.secondSubText,
    this.isCircular = false,
    this.withoutBoxShadow = false,
  })  : typeStart = 'default',
        typeEnd = 'withSecondSubText',
        options = null,
        click = null,
        userLevel = null,
        sustainablePoints = null,
        ecoScorePoints = null,
        hasBorder = null,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.withSecondSubTextAndOptions({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.secondSubText,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    required this.options,
  })  : typeStart = 'default',
        typeEnd = 'withSecondSubTextAndOptions',
        click = null,
        userLevel = null,
        sustainablePoints = null,
        ecoScorePoints = null,
        hasBorder = null,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.user({
    super.key,
    required this.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.withoutBoxShadow = false,
    required this.options,
    this.typeEnd = 'default',
    this.hasBorder = false,
    this.padding = 0,
  })  : typeStart = 'user',
        widget = null,
        subTitle = null,
        secondSubText = null,
        click = null,
        isCircular = null,
        height = heightUserCard,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.userWithoutOptions({
    super.key,
    required this.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.withoutBoxShadow = false,
    this.hasBorder = false,
    this.padding = 0,
  })  : options = null,
        typeStart = 'user',
        typeEnd = 'withoutOptions',
        widget = null,
        subTitle = null,
        secondSubText = null,
        click = null,
        isCircular = null,
        height = heightUserCard,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.userCanClick({
    super.key,
    required this.title,
    required this.userLevel,
    required this.sustainablePoints,
    required this.ecoScorePoints,
    this.withoutBoxShadow = false,
    required this.options,
    required this.click,
    this.typeEnd = 'default',
    this.hasBorder = false,
    this.padding = 0,
  })  : typeStart = 'user',
        widget = null,
        subTitle = null,
        secondSubText = null,
        isCircular = null,
        height = heightUserCard,
        dropOptions = null,
        dropOptionsValue = null,
        dropOptionsSet = null,
        workerType = null;

  CompactListItem.workerCanEditType({
    super.key,
    required this.title,
    required this.subTitle,
    this.withoutBoxShadow = false,
    required this.options,
    this.typeEnd = 'default',
    this.hasBorder = false,
    required this.dropOptions,
    required this.dropOptionsValue,
    required this.dropOptionsSet,
  })  : typeStart = 'worker',
        widget = null,
        userLevel = null,
        sustainablePoints = null,
        ecoScorePoints = null,
        secondSubText = null,
        click = null,
        isCircular = null,
        workerType = null;

  final GlobalKey _buttonKey = GlobalKey();

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
    double width = (MediaQuery.of(context).size.width);

    return Container(
      padding: EdgeInsets.all(padding),
      height: height,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _typeStart(width),
          _typeEnd(context),
        ],
      ),
    );
  }

  Widget _imageTitleAndSubtitle() {
    return Row(
      children: [
        IconButtonRectangular(
          isCircular: isCircular!,
          dimension: 60,
          object: widget!,
          withoutBoxShadow: withoutBoxShadow,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: AppText.headerBlack,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle!,
              style: AppText.subHeader,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ],
    );
  }

  Widget _typeStart(double width) {
    switch (typeStart) {
      case 'default':
        return _imageTitleAndSubtitle();

      case 'user':
        return Row(
          children: [
            Container(
              width: 70,
              height: height,
              decoration: BoxDecoration(
                color: hasBorder! ? AppColor.primaryInfo : AppColor.darkGreen,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  bottomLeft: borderRadius,
                  topLeft: borderRadius,
                ),
                boxShadow: const [AppColor.defaultShadow],
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
            Column(
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
                      points: sustainablePoints!,
                    ),
                    if (width > AppColor.maxWidthToImage)
                      Points.ecoScore(points: ecoScorePoints!),
                  ],
                )
              ],
            )
          ],
        );
      case 'worker':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ((2 / 3) * width) - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppText.smallHeader,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subTitle!,
                    style: AppText.subHeader,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 2,
              width: 125,
              child: FormattedDropDown(
                options: dropOptions!,
                value: dropOptionsValue,
                onValueChanged: dropOptionsSet!,
              ),
            ),
          ],
        );
    }
    return _imageTitleAndSubtitle();
  }

  Widget _withoutOptions() {
    return const SizedBox(
      width: 24,
    );
  }

  Widget _options(BuildContext context) {
    return InkWell(
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
    );
  }

  Widget _textUnderOptions() {
    return Positioned(
      bottom: 6,
      width: 65,
      child: Text(
        secondSubText!,
        style: AppText.subHeader,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _typeEnd(BuildContext context) {
    switch (typeEnd) {
      case 'default':
        return _options(context);
      case 'withoutOptions':
        return _withoutOptions();
      case 'withSecondSubText':
        return Stack(
          children: [
            Container(
              width: 60,
            ),
            _textUnderOptions(),
          ],
        );
      case 'withSecondSubTextAndOptions':
        return Stack(
          children: [
            Container(
              width: 60,
            ),
            Positioned(
              right: 0,
              child: _options(context),
            ),
            _textUnderOptions(),
          ],
        );
    }

    return _withoutOptions();
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
