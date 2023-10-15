import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:beat_ecoprove/core/widgets/step_by_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstStage extends StatefulWidget {
  const FirstStage({super.key});

  @override
  State<FirstStage> createState() => _FirstStageState();
}

class _FirstStageState extends State<FirstStage> {
  static const double _textBoxGap = 26;

  @override
  Widget build(BuildContext context) {
    return ScrollHandler.similiar(
      verticalPadding: 110,
      horizontalPadding: 38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              StepByStep(),
              SizedBox(
                height: SignInView.headerGap,
              ),
              Text(
                "Informações Pessoais",
                style: AppText.header,
              ),
            ],
          ),
          Column(
            children: [
              const FormattedTextField(
                hintText: 'Nome',
              ),
              const SizedBox(
                height: _textBoxGap,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Data de Nascimento",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: AppText.title5,
                      color: AppColor.widgetSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DatePicker()
                ],
              ),
              const SizedBox(
                height: _textBoxGap,
              ),
              const FormattedDropDown(
                options: ["Masculino", "Feminino", "Outros"],
              ),
              const SizedBox(
                height: _textBoxGap,
              ),
              FormattedTextField(
                hintText: "telemóvel",
                keyboardType: TextInputType.number,
                inputFormatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Onl,
              ),
            ],
          ),
          const FormattedButton(content: "Continuar")
        ],
      ),
    );
  }
}
