import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:flutter/material.dart';

class ShowCompletedViewParams {
  final String text;
  final String textButton;
  final VoidCallback action;

  ShowCompletedViewParams({
    required this.text,
    required this.textButton,
    required this.action,
  });
}

class ShowCompletedView extends StatelessWidget {
  final ShowCompletedViewParams params;

  const ShowCompletedView({
    super.key,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.completed,
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    params.text,
                    style: AppText.alternativeHeader,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 62,
                  ),
                  const Circle(
                    color: AppColor.lightGreen,
                    strokeWidth: 7,
                    height: 160,
                    child: Icon(
                      Icons.check_rounded,
                      color: AppColor.lightGreen,
                      size: 100,
                    ),
                  ),
                ],
              ),
              FormattedButton(
                content: params.textButton,
                textColor: Colors.white,
                onPress: () => params.action(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
