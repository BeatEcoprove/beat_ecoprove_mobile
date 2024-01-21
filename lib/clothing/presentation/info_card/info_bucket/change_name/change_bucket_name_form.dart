import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/change_name/change_bucket_name_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class ChangeBucketNameForm extends StatelessWidget {
  static const double textFieldsGap = 26;
  final String bucket;

  const ChangeBucketNameForm({super.key, required this.bucket});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<ChangeBucketNameViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        type: AppBackgrounds.createGroup,
        content: GoBack(
          posLeft: 24,
          posTop: 24,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    const Text(
                      "Alterar Nome do Cesto",
                      style: AppText.header,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 116),
                      child: Column(
                        children: [
                          DefaultFormattedTextField(
                            hintText: "Nome do cesto",
                            onChange: (name) => viewModel.setName(name),
                            initialValue:
                                viewModel.getValue(FormFieldValues.name).value,
                            errorMessage:
                                viewModel.getValue(FormFieldValues.name).error,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FormattedButton(
                  content: "Alterar",
                  textColor: Colors.white,
                  onPress: () async => await viewModel.changeBucketName(bucket),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
