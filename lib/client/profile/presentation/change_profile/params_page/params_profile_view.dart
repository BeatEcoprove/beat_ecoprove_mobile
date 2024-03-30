import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_page_params.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/client/profile/presentation/change_profile/params_page/params_profile_view_model.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:flutter/material.dart';

class ParamsProfileView
    extends ArgumentedView<ParamsProfileViewModel, PageParams> {
  static const double textFieldsGap = 26;

  const ParamsProfileView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, ParamsProfileViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoBack(
        posLeft: 24,
        posTop: 24,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Nova Conta",
                    style: AppText.header,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 78),
                    child: Column(
                      children: [
                        DefaultFormattedTextField(
                          hintText: "E-mail",
                          onChange: (email) => viewModel.setEmail(email),
                          initialValue:
                              viewModel.getValue(FormFieldValues.email).value,
                          errorMessage:
                              viewModel.getValue(FormFieldValues.email).error,
                        ),
                        const SizedBox(
                          height: textFieldsGap,
                        ),
                        DefaultFormattedTextField(
                          hintText: "Palavra-chave",
                          onChange: (password) =>
                              viewModel.setPassword(password),
                          initialValue: viewModel
                              .getValue(FormFieldValues.password)
                              .value,
                          errorMessage: viewModel
                              .getValue(FormFieldValues.password)
                              .error,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: textFieldsGap,
                        ),
                        DefaultFormattedTextField(
                          hintText: "Confirmar palavra-chave",
                          onChange: (confirmPassword) =>
                              viewModel.setConfirmPassword(confirmPassword),
                          initialValue: viewModel
                              .getValue(FormFieldValues.confirmPassword)
                              .value,
                          errorMessage: viewModel
                              .getValue(FormFieldValues.confirmPassword)
                              .error,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FormattedButton(
                content: "Criar",
                textColor: Colors.white,
                onPress: () async => await viewModel.promoteProfile(
                  args.params,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
