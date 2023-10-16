import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoBack extends StatefulWidget {
  final String goBackPath;
  final Widget child;

  final bool Function()? changeDefaultBehavior;

  const GoBack(
      {this.goBackPath = '/',
      this.changeDefaultBehavior,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  State<GoBack> createState() => _GoBackState();
}

class _GoBackState extends State<GoBack> {
  late bool isOverride;
  late GoRouter goRouter;

  void handleRoute() {
    bool callbackResult = false;

    if (widget.changeDefaultBehavior != null) {
      callbackResult = widget.changeDefaultBehavior!();
    }

    if (goRouter.canPop() && !callbackResult) {
      goRouter.go(widget.goBackPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    goRouter = GoRouter.of(context);

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 48,
          left: 22,
          child: CircularButton(
            onPress: handleRoute,
            height: 46,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.widgetSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
