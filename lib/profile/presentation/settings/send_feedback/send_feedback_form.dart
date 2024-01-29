import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/profile/presentation/settings/send_feedback/send_feedback_view_model.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:flutter/material.dart';

class SendFeedbackForm extends StatelessWidget {
  const SendFeedbackForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<SendFeedbackViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoBack(
        posLeft: 18,
        posTop: 18,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: AppBackground(
            content: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Enviar Feedback",
                        textAlign: TextAlign.center,
                        style: AppText.titleToScrollSection,
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      DefaultFormattedTextField(
                        hintText: "Título",
                        onChange: (name) async => viewModel.setName(name),
                        initialValue:
                            viewModel.getValue(FormFieldValues.name).value,
                        errorMessage:
                            viewModel.getValue(FormFieldValues.name).error,
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      DefaultFormattedTextField(
                        hintText: "Descrição",
                        onChange: (description) async =>
                            viewModel.setDescription(description),
                        initialValue: viewModel
                            .getValue(FormFieldValues.groupDescription)
                            .value,
                        errorMessage: viewModel
                            .getValue(FormFieldValues.groupDescription)
                            .error,
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      FormattedButton(
                        content: "Enviar",
                        textColor: Colors.white,
                        disabled: viewModel.thereAreErrors,
                        onPress: () async => await viewModel.sendFeedback(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            type: AppBackgrounds.registerClothBackground1,
          ),
        ),
      ),
    );
  }
}
