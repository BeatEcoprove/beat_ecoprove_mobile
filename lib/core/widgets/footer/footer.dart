import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/footer/footer_button_add.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final int currentIndex;
  final Function(int) onChangeSelection;
  final VoidCallback? onMiddleButtonSeleted;
  final List<Widget> options;
  final bool hasRegisterCloth;

  const Footer({
    super.key,
    required this.currentIndex,
    required this.options,
    required this.onChangeSelection,
    this.onMiddleButtonSeleted,
    required this.hasRegisterCloth,
  });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  final List<Widget> _options = [];
  late int _middleIndex = 0;

  @override
  void initState() {
    super.initState();
    _options.addAll(widget.options);

    if (widget.hasRegisterCloth) {
      _middleIndex = ((widget.options.length - 1) / 2).round();

      if (_middleIndex % 2 != 0) {
        _middleIndex = _middleIndex.floor();
      } else {
        _middleIndex = _middleIndex.ceil();
      }

      _options.insert(
        _middleIndex,
        const FooterButton(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        boxShadow: [AppColor.defaultShadow],
      ),
      child: NavigationBar(
        backgroundColor: AppColor.widgetBackground,
        elevation: 10,
        selectedIndex: widget.currentIndex,
        onDestinationSelected: (index) => {
          if (widget.hasRegisterCloth)
            {
              if (index == _middleIndex)
                {
                  widget.onMiddleButtonSeleted?.call(),
                }
              else
                {
                  widget.onChangeSelection(
                    index > _middleIndex ? index - 1 : index,
                  ),
                }
            }
          else
            {
              widget.onChangeSelection(index),
            }
        },
        destinations: mapOptions(),
        indicatorColor: Colors.transparent,
      ),
    );
  }

  Widget constructIcon(Widget value, int index) {
    switch (value.runtimeType) {
      case SvgImage:
        return SvgImage(
          path: (value as SvgImage).path,
          color: getSelectionColor(index),
        );
      case ImageProvider:
        return Image(
          image: value as ImageProvider,
          color: getSelectionColor(index),
        );
      case Icon:
        return Icon(
          (value as Icon).icon,
          color: getSelectionColor(index),
        );
      case Line:
        return Line(
          width: (value as Line).width,
          color: getSelectionColor(index),
          stroke: (value).stroke,
        );
      default:
        return value;
    }
  }

  List<NavigationDestination> mapOptions() {
    return _options.map((option) {
      int index = widget.options.indexOf(option);

      return NavigationDestination(
          label: "", icon: constructIcon(option, index));
    }).toList();
  }

  Color getSelectionColor(int index) {
    if (widget.currentIndex == index) {
      return AppColor.bottomNavigationBarSelected;
    }

    return AppColor.bottomNavigationBar;
  }
}
