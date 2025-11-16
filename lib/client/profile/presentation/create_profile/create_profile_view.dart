import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/view.dart';
import 'package:beat_ecoprove/core/widgets/avatar_chooser/circle_avatar_chooser.dart';
import 'package:beat_ecoprove/core/widgets/date_picker.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:beat_ecoprove/core/widgets/formatted_drop_down.dart';
import 'package:beat_ecoprove/core/widgets/formatted_text_field/default_formatted_text_field.dart';
import 'package:beat_ecoprove/client/profile/presentation/create_profile/create_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateProfileView extends LinearView<CreateProfileViewModel> {
  const CreateProfileView({
    super.key,
    required super.viewModel,
  });

  @override
  Widget build(BuildContext context, CreateProfileViewModel viewModel) {
    double textBoxGap = 16;
    double halfWidth = (MediaQuery.of(context).size.width / 2) - 50;

    return Scaffold(
      body: GoBack(
        posLeft: 22,
        posTop: 48,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 96,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      LocaleContext.get().client_profile_create_profile_info,
                      style: AppText.header,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 78,
                      ),
                      child: Column(
                        children: [
                          DefaultFormattedTextField(
                            hintText: LocaleContext.get()
                                .client_profile_create_profile_name,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            errorMessage: viewModel
                                .getValue(FormFieldValues.profileName)
                                .error,
                            onChange: (value) =>
                                viewModel.setProfileName(value),
                            initialValue: viewModel
                                .getValue(FormFieldValues.profileName)
                                .value,
                          ),
                          SizedBox(
                            height: textBoxGap,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: halfWidth,
                                child: Text(
                                  LocaleContext.get()
                                      .client_profile_create_profile_birth_date,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: AppText.title5,
                                    color: AppColor.widgetSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                            height: textBoxGap,
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
                            height: textBoxGap,
                          ),
                          DefaultFormattedTextField(
                            hintText: LocaleContext.get()
                                .client_profile_create_profile_username,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(18),
                            ],
                            errorMessage: viewModel
                                .getValue(FormFieldValues.profileUserName)
                                .error,
                            onChange: (value) async =>
                                await viewModel.setProfileUserName(value),
                            initialValue: viewModel
                                .getValue(FormFieldValues.profileUserName)
                                .value,
                          ),
                          SizedBox(
                            height: textBoxGap,
                          ),
                          //FIXME: Enable profile picture upload later
                          // CircleAvatarChooser(
                          //   height: 140,
                          //   color: AppColor.widgetSecondary,
                          //   imageProvider: viewModel.getProfilePicture(),
                          //   onPress: () => viewModel.getImageFromGallery(),
                          // ),
                          SizedBox(
                            height: 2 * textBoxGap,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FormattedButton(
                  content: LocaleContext.get()
                      .client_profile_create_profile_continue,
                  textColor: Colors.white,
                  disabled: viewModel.thereAreErrors,
                  onPress: () async => await viewModel.registerProfile(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
