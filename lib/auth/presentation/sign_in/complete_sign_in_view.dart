import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step/circle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompleteSignInView extends StatelessWidget {
  const CompleteSignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);

    return Scaffold(
      body: AppBackground(
        type: AppBackgrounds.completed,
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                children: [
                  Text(
                    "Conta criada com sucesso",
                    style: AppText.alternativeHeader,
                  ),
                  SizedBox(
                    height: 62,
                  ),
                  Circle(
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
                content: "Entrar",
                onPress: () => router.go("/"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
