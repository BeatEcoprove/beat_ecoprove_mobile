import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/overlay_widget_with_button.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class LevelUpProvider extends ViewModel {
  late BuildContext context;
  late Modal _overlay;

  void initState() {
    _overlay = Modal(
      top: 72,
      bottom: 72,
      left: 36,
      right: 36,
      action: () {},
      titleModal: "Parabéns! Subiu de nível!",
      buttonText: "Confirmar",
      hasCancelButton: false,
    );
  }

  setContext(BuildContext context) {
    this.context = context;
    initState();
    notifyListeners();
  }

  void showLevelUpNotification({int level = 0}) {
    _overlay.create(
      context,
      _content(level: level),
    );
  }

  Widget _content({int level = 0}) {
    const double ratioOffset = 80;
    const double heightStack = 175;
    const double widthStack = 220;

    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Container(
                height: heightStack,
                width: widthStack,
              ),
            ),
            const Positioned(
              left: 0,
              child: SvgImage(
                height: 150,
                width: 150,
                path: 'assets/level_up/leaf1.svg',
              ),
            ),
            const Positioned(
              right: 0,
              child: SvgImage(
                height: 150,
                width: 150,
                path: 'assets/level_up/leaf2.svg',
              ),
            ),
            const Positioned(
              top: -5,
              left: widthStack / 2 - 20,
              child: SvgImage(
                height: 50,
                width: 50,
                path: 'assets/level_up/crown.svg',
              ),
            ),
            Positioned(
              bottom: heightStack / 2 - 40,
              left: widthStack / 2 - 40,
              child: ClipOval(
                child: Container(
                  width: ratioOffset,
                  height: ratioOffset,
                  decoration: const BoxDecoration(
                      color: AppColor.widgetBackground,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [AppColor.defaultShadow]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Nível",
                        style: AppText.smallSubHeader,
                      ),
                      Text(
                        level.toString(),
                        style: AppText.smallHeader,
                      ),
                      const Text(
                        "0%",
                        style: AppText.percentText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
