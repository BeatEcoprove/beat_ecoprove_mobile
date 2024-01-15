import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/profile/presentation/create_profile/create_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CreateProfileForm extends StatelessWidget {
  const CreateProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<CreateProfileViewModel>(context);
    final goRouter = GoRouter.of(context);
    double _textBoxGap = 16;

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
                  const Text(
                    "Informações Pessoais",
                    style: AppText.header,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 78),
                    child: Column(
                      children: [
                        DefaultFormattedTextField(
                          hintText: 'Nome',
                          errorMessage: viewModel
                              .getValue(FormFieldValues.profileName)
                              .error,
                          onChange: (value) => viewModel.setProfileName(value),
                          initialValue: viewModel
                              .getValue(FormFieldValues.profileName)
                              .value,
                        ),
                        SizedBox(
                          height: _textBoxGap,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Data de Nascimento",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: AppText.title5,
                                color: AppColor.widgetSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DatePicker(
                              value: viewModel
                                  .getValue(FormFieldValues.profileBornDate)
                                  .value,
                            )
                          ],
                        ),
                        SizedBox(
                          height: _textBoxGap,
                        ),
                        FormattedDropDown(
                          options: Gender.getAllTypes()
                              .map((e) => e.displayValue)
                              .toList(),
                          value: viewModel
                              .getValue(FormFieldValues.profileGender)
                              .value
                              .toString(),
                          onValueChanged: (value) => viewModel.setValue(
                              FormFieldValues.profileGender, value),
                        ),
                        SizedBox(
                          height: _textBoxGap,
                        ),
                        DefaultFormattedTextField(
                          hintText: 'Nome de exibição',
                          errorMessage: viewModel
                              .getValue(FormFieldValues.profileUserName)
                              .error,
                          onChange: (value) =>
                              viewModel.setProfileUserName(value),
                          initialValue: viewModel
                              .getValue(FormFieldValues.profileUserName)
                              .value,
                        ),
                        SizedBox(
                          height: _textBoxGap,
                        ),
                        CircleAvatarChooser(
                          height: 140,
                          color: AppColor.widgetSecondary,
                          imageProvider: viewModel.getProfilePicture(),
                          onPress: () => viewModel.getImageFromGallery(),
                        ),
                        SizedBox(
                          height: _textBoxGap,
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
                onPress: () => viewModel.registerProfile(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
