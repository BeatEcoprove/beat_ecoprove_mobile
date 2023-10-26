import 'dart:io';

import 'package:beat_ecoprove/auth/domain/errors/domain_exception.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/user_name.dart';
import 'package:beat_ecoprove/core/helpers/form/form_view_model.dart';
import 'package:beat_ecoprove/core/helpers/form/form_field_values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarStageViewModel extends FormViewModel {
  static const defaultImage = "assets/default_avatar.png";

  AvatarStageViewModel() {
    initializeFields([FormFieldValues.userName, FormFieldValues.avatar]);
    setValue(FormFieldValues.avatar, XFile(defaultImage));
    setValue(FormFieldValues.userName, "user_name");
  }

  void setUserName(String userName) {
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
