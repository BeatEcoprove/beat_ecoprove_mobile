import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_params.dart';
import 'package:beat_ecoprove/core/presentation/show_compled/show_completed_view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:flutter/material.dart';

class ShowCompletedView
    extends ArgumentView<ShowCompltedViewModel, ShowCompletedViewParams> {
  const ShowCompletedView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ShowCompltedViewModel viewModel) {
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
                    args.text,
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
                content: args.textButton,
                textColor: Colors.white,
                onPress: () => args.action(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
