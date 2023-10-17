import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:beat_ecoprove/auth/presentation/sign_in/sign_in_view_model.dart';
import 'package:beat_ecoprove/auth/widgets/scroll_handler.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/formated_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EnterpriseStage extends StatefulWidget {
  const EnterpriseStage({super.key});

  @override
  State<EnterpriseStage> createState() => _EnterpriseStageState();
}

class _EnterpriseStageState extends State<EnterpriseStage> {
  static const double _textBoxGap = 26;

  @override
  Widget build(BuildContext context) {
    final SignInController signController = Provider.of(context);
    final viewModel = ViewModel.of<SignInViewModel>(context);

    return ScrollHandler.similiar(
        verticalPadding: 110,
        horizontalPadding: 38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Column(
                  children: [
                    Text(
                      "Informações Do Prestador de Serviço",
                      style: AppText.header,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 78),
                  child: Column(
                    children: [
                      FormattedTextField(
                        hintText: 'Nome',
                        onChange: (value) => viewModel.setName(value),
                        initialValue: viewModel.name,
                        errorMessage: viewModel.nameError,
                      ),
                      const SizedBox(
                        height: _textBoxGap,
                      ),
                      FormattedDropDown(
                        options: viewModel.typeOptions,
                        value: viewModel.currentTypeOption,
                        onValueChanged: (value) =>
                            viewModel.setTypeOption(value),
                      ),
                      const SizedBox(
                        height: _textBoxGap,
                      ),
                      FormattedTextField(
                        hintText: "telemóvel",
                        keyboardType: TextInputType.number,
                        onChange: (value) => viewModel.setPhone("+351", value),
                        initialValue: viewModel.phone,
                        errorMessage: viewModel.phoneError,
                      ),
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
        ));
  }
}
