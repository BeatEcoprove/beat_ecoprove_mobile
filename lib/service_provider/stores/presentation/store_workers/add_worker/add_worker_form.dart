import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/store_workers/add_worker/add_worker_view_model.dart';
import 'package:flutter/material.dart';

class AddWorkerForm extends StatelessWidget {
  const AddWorkerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<AddWorkerViewModel>(context);
    double textBoxGap = 16;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoBack(
        posLeft: 22,
        posTop: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Insira o e-mail do seu funcionário",
                    style: AppText.header,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 78),
                    child: Column(
                      children: [
                        DefaultFormattedTextField(
                          hintText: 'Email',
                          errorMessage:
                              viewModel.getValue(FormFieldValues.email).error,
                          onChange: (value) => viewModel.setEmail(value),
                          initialValue:
                              viewModel.getValue(FormFieldValues.email).value,
                        ),
                        SizedBox(
                          height: textBoxGap,
                        ),
                        FormattedDropDown(
                          options: viewModel.types,
                          value: viewModel.getValue(FormFieldValues.code).value,
                          onValueChanged: (value) =>
                              viewModel.setValue(FormFieldValues.code, value),
                        ),
                        SizedBox(
                          height: textBoxGap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FormattedButton(
                content: "Continuar",
                textColor: Colors.white,
                disabled: viewModel.thereAreErrors,
                onPress: () async => await viewModel.registerWorker(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
