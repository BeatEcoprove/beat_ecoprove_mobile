import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/profile/contracts/register_profile_request.dart';
import 'package:beat_ecoprove/profile/domain/use-cases/register_group_use_case.dart';
import 'package:beat_ecoprove/profile/domain/value_objects/profile_name.dart';
import 'package:beat_ecoprove/profile/domain/value_objects/profile_user_name.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";
  final RegisterProfileUseCase _registerProfileUseCase;
  final GoRouter _navigationRouter;

  CreateProfileViewModel(
    this._navigationRouter,
    this._registerProfileUseCase,
  ) {
    initializeFields([
      FormFieldValues.profileName,
      FormFieldValues.profileBornDate,
      FormFieldValues.profileGender,
      FormFieldValues.profilePicture,
      FormFieldValues.profileUserName,
    ]);
    setValue(FormFieldValues.profileName, "");
    setValue(FormFieldValues.profileBornDate, DateTime.now());
    setValue(FormFieldValues.profileGender, Gender.getAllTypes().firstOrNull);
    setValue(FormFieldValues.profilePicture, XFile(defaultImage));
    setValue(FormFieldValues.profileUserName, "");
  }

  void setProfileName(String profileName) {
    try {
      setValue<String>(FormFieldValues.profileName,
          ProfileName.create(profileName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.profileName, e.message);
    }
  }

  void setProfileUserName(String profileUserName) {
    try {
      setValue<String>(FormFieldValues.profileUserName,
          ProfileUserName.create(profileUserName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.profileUserName, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.profilePicture, pickedFile);
    }
  }

  ImageProvider getProfilePicture() {
    if (getValue<XFile>(FormFieldValues.profilePicture).value!.path ==
        defaultImage) {
      return const AssetImage(defaultImage);
    }

    var profileImage =
        getValue<XFile>(FormFieldValues.profilePicture).value as XFile;

    return FileImage(File(profileImage.path));
  }

  void registerProfile() async {
    try {
      await _registerProfileUseCase.handle(RegisterProfileRequest(
        getValue(FormFieldValues.profileName).value ?? "",
        getValue(FormFieldValues.profileBornDate).value ?? DateTime.now(),
        Gender.getOf(getValue(FormFieldValues.profileGender).value ?? ""),
        getValue(FormFieldValues.profilePicture).value ?? "",
        getValue(FormFieldValues.profileUserName).value ?? "",
      ));

      _navigationRouter.pop();
      _navigationRouter.push("/show_completed",
          extra: ShowCompletedViewParams(
              text: "Perfil criado com sucesso",
              textButton: "Confirmar",
              route: '/changeprofile'));
    } catch (e) {
      print("$e");
    }

    notifyListeners();
  }
}
