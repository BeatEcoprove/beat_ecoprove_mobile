import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:flutter/material.dart';

class CompactListItem extends StatelessWidget {
  static const Radius borderRadius = Radius.circular(10);

  final List<OptionItem>? options;

  final Widget widget;
  final String title;
  final String subTitle;
  final bool isCircular;
  final bool withoutBoxShadow;
  final String? state;
  final String type;

  CompactListItem({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    required this.options,
    this.type = 'default',
  }) : state = null;

  CompactListItem.withoutOptions({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    this.type = 'withoutOptions',
  })  : state = null,
        options = null;

  CompactListItem.group({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.state,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    this.type = 'group',
  }) : options = null;

  CompactListItem.groupWithOptions({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.state,
    this.isCircular = false,
    this.withoutBoxShadow = false,
    this.type = 'groupWithOptions',
    required this.options,
  });

  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 75,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonRectangular(
            isCircular: isCircular,
            dimension: 60,
            object: widget,
            withoutBoxShadow: withoutBoxShadow,
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
                Text(
                  subTitle,
                  style: AppText.subHeader,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          _typeOptions(context),
        ],
      ),
    );
  }

  Widget _typeOptions(BuildContext context) {
    switch (type) {
      case 'default':
        return IconButton(
          key: _buttonKey,
          onPressed: () {
            _showOptionsMenu(context);
          },
          icon: const Icon(Icons.more_vert_rounded),
          color: AppColor.widgetSecondary,
        );
      case 'withoutOptions':
        return const SizedBox(
          width: 24,
        );
      case 'group':
        return Stack(
          children: [
            Container(
              width: 60,
            ),
            Positioned(
              bottom: 6,
              width: 65,
              child: Text(
                state!,
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      case 'groupWithOptions':
        return Stack(
          children: [
            Container(
              width: 60,
            ),
            Positioned(
              right: 0,
              child: IconButton(
                key: _buttonKey,
                onPressed: () {
                  _showOptionsMenu(context);
                },
                icon: const Icon(Icons.more_vert_rounded),
                color: AppColor.widgetSecondary,
              ),
            ),
            Positioned(
              bottom: 0,
              width: 65,
              child: Text(
                state!,
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
    }

    return const SizedBox(
      width: 24,
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
