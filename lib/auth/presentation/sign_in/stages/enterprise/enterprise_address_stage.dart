import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/enterprise/enterprise_address_stage_view_model.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/stages/form_field_values.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterpriseAddressStage extends StatefulWidget {
  const EnterpriseAddressStage({super.key});

  @override
  State<EnterpriseAddressStage> createState() => _EnterpriseAddressStageState();
}

class _EnterpriseAddressStageState extends State<EnterpriseAddressStage> {
  static const double _textBoxGap = 26;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context);
    final viewModel = ViewModel.of<EnterpriseAddressStageViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Morada",
              style: AppText.header,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  FormattedDropDown(
                    onValueChanged: (country) =>
                        viewModel.setValue(FormFieldValues.country, country),
                    value: viewModel.getValue(FormFieldValues.country).value,
                    options: viewModel.countries,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedDropDown(
                    options: viewModel.getLocalities(),
                    onValueChanged: (locality) =>
                        viewModel.setValue(FormFieldValues.locality, locality),
                    value: viewModel.getValue(FormFieldValues.locality).value,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedTextField(
                    hintText: "Rua",
                    onChange: (street) => viewModel.setStreet(street),
                    initialValue:
                        viewModel.getValue(FormFieldValues.street).value,
                    errorMessage:
                        viewModel.getValue(FormFieldValues.street).error,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: FormattedTextField(
                        hintText: "Codigo Postal",
                        initialValue:
                            viewModel.getDefault(FormFieldValues.postalCode),
                        onChange: (postalCode) =>
                            viewModel.setPostalCode(postalCode),
                        errorMessage: viewModel
                            .getValue(FormFieldValues.postalCode)
                            .error,
                      )),
                      // ignore: prefer_const_constructors
                      SizedBox(width: 24),
                      Expanded(
                        child: FormattedTextField(
                          hintText: "Porta",
                          initialValue:
                              viewModel.getDefault(FormFieldValues.port),
                          onChange: (port) => viewModel.setPort(port),
                          errorMessage:
                              viewModel.getValue(FormFieldValues.port).error,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: "Continuar",
          disabled: viewModel.thereAreErrors,
          onPress: () => controller.nextPage(viewModel.fields),
        )
      ],
    );
  }
}
