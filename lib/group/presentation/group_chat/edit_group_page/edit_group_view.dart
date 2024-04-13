import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_params.dart';
import 'package:beat_ecoprove/group/presentation/group_chat/edit_group_page/edit_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditGroupView extends ArgumentView<EditGroupViewModel, EditGroupParams> {
  const EditGroupView({
    super.key,
    required super.viewModel,
    required super.args,
  });

  @override
  Widget build(BuildContext context, EditGroupViewModel viewModel) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
          content: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoBack(
              posLeft: 22,
              posTop: 48,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 26,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 112,
                            ),
                            const Text(
                              "Criar um Grupo",
                              style: AppText.header,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 42,
                            ),
                            CircleAvatarChooser(
                              height: 140,
                              color: AppColor.widgetSecondary,
                              imageProvider: viewModel.getGroupPicture(),
                              onPress: () => viewModel.getImageFromGallery(),
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            DefaultFormattedTextField(
                              hintText: "Novo Nome",
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(25),
                              ],
                              onChange: (groupName) async =>
                                  viewModel.setGroupName(groupName),
                              initialValue: viewModel
                                  .getValue(FormFieldValues.groupName)
                                  .value,
                              errorMessage: viewModel
                                  .getValue(FormFieldValues.groupName)
                                  .error,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            DefaultFormattedTextField(
                              hintText: "Nova Descrição",
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(100),
                              ],
                              onChange: (groupDescription) async => viewModel
                                  .setGroupDescription(groupDescription),
                              initialValue: viewModel
                                  .getValue(FormFieldValues.groupDescription)
                                  .value,
                              errorMessage: viewModel
                                  .getValue(FormFieldValues.groupDescription)
                                  .error,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            FormattedDropDown(
                              options: const ['Público', 'Privado'],
                              value: viewModel
                                  .getValue(FormFieldValues.groupIsPublic)
                                  .value,
                              onValueChanged: (value) => viewModel.setValue(
                                  FormFieldValues.groupIsPublic, value),
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            FormattedButton(
                              content: "Confirmar",
                              textColor: Colors.white,
                              disabled: viewModel.thereAreErrors,
                              onPress: () async =>
                                  await viewModel.updateGroup(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          type: AppBackgrounds.createGroup),
    );
  }
}
