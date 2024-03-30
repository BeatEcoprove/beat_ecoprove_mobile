import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/formatters/postal_code_formatter.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/service_provider/stores/presentation/create_store/create_store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateStoreView extends IView<CreateStoreViewModel> {
  const CreateStoreView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, CreateStoreViewModel viewModel) {
    double maxWidth = (MediaQuery.of(context).size.width) - 48;

    return Scaffold(
      body: AppBackground(
          content: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoBack(
              posLeft: 22,
              posTop: 48,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 26),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 112,
                            ),
                            const Text(
                              "Criar Loja",
                              style: AppText.header,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            CircleAvatarChooser(
                              height: 140,
                              color: AppColor.widgetSecondary,
                              imageProvider: viewModel.getStorePicture(),
                              onPress: () => viewModel.getImageFromGallery(),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Line(
                              width: 125,
                              color: AppColor.separatedLine,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Wrap(
                              runSpacing: 16,
                              children: [
                                FormattedDropDown(
                                  //TODO: CHANGE
                                  options: const ['Portugal', 'Espanha'],
                                  value: viewModel
                                      .getValue(FormFieldValues.storeCountry)
                                      .value,
                                  onValueChanged: (value) => viewModel.setValue(
                                      FormFieldValues.storeCountry, value),
                                ),
                                FormattedDropDown(
                                  //TODO: CHANGE
                                  options: const ['Lisboa', 'Porto'],
                                  value: viewModel
                                      .getValue(FormFieldValues.storeLocality)
                                      .value,
                                  onValueChanged: (value) => viewModel.setValue(
                                      FormFieldValues.storeLocality, value),
                                ),
                                DefaultFormattedTextField(
                                  hintText: "Rua",
                                  onChange: (storeStreet) async =>
                                      viewModel.setStoreStreet(storeStreet),
                                  initialValue: viewModel
                                      .getValue(FormFieldValues.storeStreet)
                                      .value,
                                  errorMessage: viewModel
                                      .getValue(FormFieldValues.storeStreet)
                                      .error,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: (2 / 3) * maxWidth,
                                      child: DefaultFormattedTextField(
                                        hintText: "Código Postal",
                                        inputFormatter: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(7),
                                          PostalCodeFormatter(),
                                        ],
                                        initialValue: viewModel.getDefault(
                                            FormFieldValues.postalCode),
                                        onChange: (postalCode) => viewModel
                                            .setStorePostalCode(postalCode),
                                        errorMessage: viewModel
                                            .getValue(
                                                FormFieldValues.postalCode)
                                            .error,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(
                                      width: (1 / 3) * maxWidth,
                                      child: DefaultFormattedTextField(
                                        hintText: "Porta",
                                        inputFormatter: [
                                          LengthLimitingTextInputFormatter(8),
                                        ],
                                        onChange: (storeNumberPort) async =>
                                            viewModel.setStoreNumberPort(
                                                storeNumberPort),
                                        initialValue: viewModel
                                            .getValue(
                                                FormFieldValues.storeNumberPort)
                                            .value,
                                        errorMessage: viewModel
                                            .getValue(
                                                FormFieldValues.storeNumberPort)
                                            .error,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            FormattedButton(
                              content: "Registar",
                              textColor: Colors.white,
                              disabled: viewModel.thereAreErrors,
                              onPress: () async => viewModel.registerStore(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          type: AppBackgrounds.createGroup),
    );
  }
}
