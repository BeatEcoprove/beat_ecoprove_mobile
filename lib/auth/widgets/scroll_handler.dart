import 'package:flutter/material.dart';

class ScrollHandler extends StatelessWidget {
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final Widget child;

  const ScrollHandler(
      {this.topPadding = 0,
      this.bottomPadding = 0,
      this.leftPadding = 0,
      this.rightPadding = 0,
      required this.child,
      Key? key})
      : super(key: key);

  const ScrollHandler.similiar(
      {double horizontalPadding = 0,
      double verticalPadding = 0,
      required this.child,
      Key? key})
      : topPadding = verticalPadding,
        bottomPadding = verticalPadding,
        rightPadding = horizontalPadding,
        leftPadding = horizontalPadding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                left: leftPadding,
                right: rightPadding,
                top: topPadding,
                bottom: bottomPadding),
            child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: _calculateScreenHeight(context)),
                child: child)));
  }

  double _calculateScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - (topPadding + bottomPadding);
  }
}
