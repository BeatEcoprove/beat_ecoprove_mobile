import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
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
    final SignInController signController = Provider.of(context);
    final viewModel = ViewModel.of<SignInViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Column(
              children: [
                Text(
                  "Morada",
                  style: AppText.header,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Column(
                children: [
                  FormattedDropDown(
                    options: viewModel.countries.keys.toList(),
                    onValueChanged: (country) =>
                        viewModel.chooseCountry(country),
                    value: viewModel.choosenCountry,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedDropDown(
                    options: viewModel.currentLocalities,
                    onValueChanged: (locality) =>
                        viewModel.setLocality(locality),
                    value: viewModel.choosenLocality,
                  ),
                  const SizedBox(
                    height: _textBoxGap,
                  ),
                  FormattedTextField(
                    hintText: "Rua",
                    onChange: (street) => viewModel.setStreet(street),
                    initialValue: viewModel.street,
                    errorMessage: viewModel.streetError,
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
                        initialValue: viewModel.postalCode,
                        onChange: (postalCode) =>
                            viewModel.setPostalCode(postalCode),
                        errorMessage: viewModel.postalCodeError,
                      )),
                      // ignore: prefer_const_constructors
                      SizedBox(width: 24),
                      Expanded(
                          child: FormattedTextField(
                        hintText: "Porta",
                        initialValue: viewModel.port,
                        onChange: (port) => viewModel.setPort(port),
                        errorMessage: viewModel.portError,
                      )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        FormattedButton(
          content: "Continuar",
          onPress: () => signController.nextPage(),
        )
      ],
    );
  }
}
