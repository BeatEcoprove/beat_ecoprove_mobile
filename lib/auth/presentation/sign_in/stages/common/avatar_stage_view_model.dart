import 'dart:io';

import 'package:beat_ecoprove/auth/contracts/validate_field_request.dart';
import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/user_name.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:beat_ecoprove/core/stage_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarStageViewModel extends StageViewModel {
  static const defaultImage = "assets/default_avatar.png";
  final AuthenticationService _authenticationService;

  AvatarStageViewModel(super.signInViewModel, this._authenticationService) {
    initializeFields([
      FormFieldValues.userName,
      FormFieldValues.avatar,
    ]);
    setValue(FormFieldValues.avatar, XFile(defaultImage));
  }

  @override
  void setDefaults(Map<FormFieldValues, FormFieldModel> data) {
    super.setDefaults(data);

    setToDefaultField(
      FormFieldValues.avatar,
      data[FormFieldValues.avatar]?.value ?? XFile(defaultImage),
    );
  }

  Future<void> setUserName(String userName) async {
    userName = userName.trim();

    try {
      bool isValid = await _authenticationService
          .validateFields(ValidateFieldRequest("username", userName));

      if (!isValid) {
        setError(
          FormFieldValues.userName,
          LocaleContext.get().auth_avatar_user_already_exists,
        );

        return;
      }
    } on HttpError {}

    try {
      setValue<String>(
          FormFieldValues.userName, UserName.create(userName).toString());
    } on DomainException catch (e) {
      setError(FormFieldValues.userName, e.message);
    }
  }

  void getImageFromGallery() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setValue<XFile>(FormFieldValues.avatar, pickedFile);
    }
  }

  ImageProvider getAvatarImage() {
    if (getValue<XFile>(FormFieldValues.avatar).value!.path == defaultImage) {
      return const AssetImage(defaultImage);
    }

    var userImage = getValue<XFile>(FormFieldValues.avatar).value as XFile;

    return FileImage(File(userImage.path));
  }
}
