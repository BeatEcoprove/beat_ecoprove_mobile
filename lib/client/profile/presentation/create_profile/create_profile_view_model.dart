import 'dart:io';

import 'package:beat_ecoprove/auth/contracts/validate_field_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/gender.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/name.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_badrequest_error.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/presentation/complete_sign_in_view.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/client/profile/contracts/register_profile_request.dart';
import 'package:beat_ecoprove/client/profile/domain/use-cases/register_profile_use_case.dart';
import 'package:beat_ecoprove/client/profile/domain/value_objects/profile_user_name.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileViewModel extends FormViewModel {
  final NotificationProvider _notificationProvider;
  final AuthenticationService _authenticationService;
  static const defaultImage = "assets/default_avatar.png";
  final RegisterProfileUseCase _registerProfileUseCase;
  final INavigationManager _navigationRouter;

  CreateProfileViewModel(
    this._notificationProvider,
    this._navigationRouter,
    this._registerProfileUseCase,
    this._authenticationService,
  ) {
    initializeFields([
      FormFieldValues.profileName,
      FormFieldValues.profileBornDate,
      FormFieldValues.profileGender,
      FormFieldValues.profilePicture,
      FormFieldValues.profileUserName,
    ]);
    setValue(FormFieldValues.profileBornDate, DateTime.now());
    setValue(FormFieldValues.profileGender,
        Gender.getAllTypes().firstOrNull?.displayValue);
    setValue(FormFieldValues.profilePicture, XFile(defaultImage));
  }

  void setProfileName(String profileName) {
    try {
      int spaceCount = profileName.split(" ").length - 1;

      if (spaceCount == 0 || spaceCount > 1) {
        throw DomainException(
            "Insira o seu primeiro e segundo nome separado por um espaço.");
      }

      var [firstName, lastName] = profileName.split(" ");

      setValue<String>(FormFieldValues.profileName,
          Name.create(firstName, lastName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.profileName, e.message);
    }
  }

  Future setProfileUserName(String profileUserName) async {
    try {
      bool isValid = await _authenticationService
          .validateFields(ValidateFieldRequest("username", profileUserName));

      if (!isValid) {
        setError(
            FormFieldValues.profileUserName, "O nome de utilizador já existe");
        return;
      }
    } on HttpError {
      return;
    }

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

  Future registerProfile() async {
    try {
      await _registerProfileUseCase.handle(RegisterProfileRequest(
        getValue(FormFieldValues.profileName).value ?? "",
        getValue(FormFieldValues.profileBornDate).value ?? DateTime.now(),
        Gender.getOf(getValue(FormFieldValues.profileGender).value ??
            Gender.getAllTypes().firstOrNull?.displayValue),
        getValue(FormFieldValues.profilePicture).value ?? "",
        getValue(FormFieldValues.profileUserName).value ?? "",
      ));

      _navigationRouter.pop();
      _navigationRouter.push("/show_completed",
          extras: ShowCompletedViewParams(
              text: "Perfil criado com sucesso",
              textButton: "Confirmar",
              action: () => _navigationRouter.pop()));
    } on HttpBadRequestError catch (e) {
      _notificationProvider.showNotification(
        e.getError().title,
        type: NotificationTypes.error,
      );
    } catch (e) {
      print("$e");
      _notificationProvider.showNotification(
        e.toString(),
        type: NotificationTypes.error,
      );
      return;
    }

    notifyListeners();
  }
}
